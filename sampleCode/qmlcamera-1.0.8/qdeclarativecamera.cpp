/****************************************************************************
**
** Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the plugins of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions
** contained in the Technology Preview License Agreement accompanying
** this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights.  These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
**
**
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "qdeclarativecamera_p.h"
#include "qdeclarativecamerapreviewprovider_p.h"

#include <qmediaplayercontrol.h>
#include <qmediaservice.h>
#include <QPainter>
#include <qvideorenderercontrol.h>
#include <QtDeclarative/qdeclarativeinfo.h>

#include <QtCore/QTimer>
#include <QtGui/qevent.h>

#include <QDebug>


#define CAMERA_ERR_MSG_RESOURCES_RESERVED "Resources reserved"


QT_BEGIN_NAMESPACE

class FocusZoneItem : public QGraphicsItem {
public:
    FocusZoneItem(const QCameraFocusZone & zone, const QColor &color, QGraphicsItem *parent = 0)
        :QGraphicsItem(parent),m_zone(zone), m_color(color)
    {}

    virtual ~FocusZoneItem() {}
    void paint(QPainter *painter,
               const QStyleOptionGraphicsItem *option,
               QWidget *widget = 0)
    {
        Q_UNUSED(widget);
        Q_UNUSED(option);

        painter->setPen(QPen(QBrush(m_color), 2.5));
        QRectF r = boundingRect();
        QPointF dw(r.width()/10, 0);
        QPointF dh(0, r.width()/10);

        painter->drawLine(r.topLeft(), r.topLeft()+dw);
        painter->drawLine(r.topLeft(), r.topLeft()+dh);

        painter->drawLine(r.topRight(), r.topRight()-dw);
        painter->drawLine(r.topRight(), r.topRight()+dh);

        painter->drawLine(r.bottomLeft(), r.bottomLeft()+dw);
        painter->drawLine(r.bottomLeft(), r.bottomLeft()-dh);

        painter->drawLine(r.bottomRight(), r.bottomRight()-dw);
        painter->drawLine(r.bottomRight(), r.bottomRight()-dh);
    }

    QRectF boundingRect() const {
        if (!parentItem())
            return QRectF();

        QRectF p = parentItem()->boundingRect();
        QRectF zone = m_zone.area();

        return QRectF(p.left() + zone.left()*p.width(),
                      p.top() + zone.top()*p.height(),
                      p.width()*zone.width(),
                      p.height()*zone.height());
    }


    QCameraFocusZone m_zone;
    QColor m_color;
};


void QDeclarativeCamera::_q_nativeSizeChanged(const QSizeF &size)
{
    setImplicitWidth(size.width());
    setImplicitHeight(size.height());
}

void QDeclarativeCamera::_q_error(int errorCode, const QString &errorString)
{
    emit error(Error(errorCode), errorString);
    emit errorChanged();
}

void QDeclarativeCamera::_q_cameraError(QCamera::Error errorCode)
{
    _q_error(errorCode, m_camera->errorString());
}

void QDeclarativeCamera::_q_imageCaptured(int id, const QImage &preview)
{
    m_capturedImagePreview = preview;
    QString previewId = QString("preview_%1").arg(id);
    QDeclarativeCameraPreviewProvider::registerPreview(previewId, preview);

    emit imageCaptured(QLatin1String("image://meegocamera/")+previewId);
}

void QDeclarativeCamera::_q_imageSaved(int id, const QString &fileName)
{
    Q_UNUSED(id);
    m_capturedImagePath = fileName;
    emit imageSaved(fileName);
}

void QDeclarativeCamera::_q_updateMode(QCamera::CaptureMode mode)
{
    emit cameraModeChanged(QDeclarativeCamera::Mode(mode));
}

void QDeclarativeCamera::_q_updateState(QCamera::State state)
{
    emit cameraStateChanged(QDeclarativeCamera::State(state));
}

void QDeclarativeCamera::_q_updateRecordingState(QMediaRecorder::State state)
{
    emit recordingStateChanged(QDeclarativeCamera::RecordingState(state));
}

void QDeclarativeCamera::_q_updateLockStatus(QCamera::LockType type,
                                             QCamera::LockStatus status,
                                             QCamera::LockChangeReason reason)
{
    if (type == QCamera::LockFocus) {
        if (status == QCamera::Unlocked && reason == QCamera::LockFailed) {
            //display failed focus points in red for 1 second
            m_focusFailedTime = QTime::currentTime();
            QTimer::singleShot(1000, this, SLOT(_q_updateFocusZones()));
        } else {
            m_focusFailedTime = QTime();
        }
        _q_updateFocusZones();
    }
}

void QDeclarativeCamera::_q_updateFocusZones()
{
    qDeleteAll(m_focusZones);
    m_focusZones.clear();

    foreach(const QCameraFocusZone &zone, m_camera->focus()->focusZones()) {
        QColor c;
        QCamera::LockStatus lockStatus = m_camera->lockStatus(QCamera::LockFocus);

        if (lockStatus == QCamera::Unlocked) {
            //display failed focus points in red for 1 second
            if (zone.status() == QCameraFocusZone::Selected &&
                    m_focusFailedTime.msecsTo(QTime::currentTime()) < 500) {
                c = Qt::red;
            }
        } else {
            switch (zone.status()) {
            case QCameraFocusZone::Focused:
                c = Qt::green;
                break;
            case QCameraFocusZone::Selected:
                c = lockStatus == QCamera::Searching ? Qt::yellow : Qt::black;
                break;
            default:
                c= QColor::Invalid;
                break;
            }
        }

        if (c.isValid())
            m_focusZones.append(new FocusZoneItem(zone, c, m_viewfinderItem));
    }
}

void QDeclarativeCamera::_q_updateImageSettings()
{
    if (m_imageSettingsChanged) {
        m_imageSettingsChanged = false;
        m_capture->setEncodingSettings(m_imageSettings);
        m_capture->setProperty("previewResolution", m_previewResolution);
        m_recorder->setEncodingSettings( QAudioEncoderSettings(), m_videoSettings);
        m_camera->setProperty("viewfinderResolution", m_viewfinderResolution);
        m_camera->setProperty("viewfinderFramerate", m_viewfinderFramerate);
    }
}

void QDeclarativeCamera::_q_applyPendingState()
{
    if (!m_isStateSet) {

        // Update possibly pending settings here
        // If updated after switching to ActiveState the camera backend may
        // be unnecessary reloaded
        if(m_pendingState == QDeclarativeCamera::ActiveState )
            _q_updateImageSettings();

        m_isStateSet = true;

        // Always acquire resources when setting state for the first time
        m_resourcesStatus = QDeclarativeCamera::ResourcesNotNeeded;

        setCameraState(m_pendingState);
    }
}

void QDeclarativeCamera::_q_captureFailed(int id, QCameraImageCapture::Error error, const QString &message)
{
    Q_UNUSED(id);
    Q_UNUSED(error);
    emit captureFailed(message);
}

void QDeclarativeCamera::_q_recordFailed(QMediaRecorder::Error error)
{
    Q_UNUSED(error);
    emit captureFailed(m_recorder->errorString());
}

/*!
    \qmlclass Video QDeclarativeCamera
    \since 4.7
    \brief The Camera element allows you to add camera viewfinder to a scene.
    \inherits Item

    This element is part of the \bold{Qt.camera 4.7} module.

    \qml
    import Qt 4.7
    import Qt.camera 4.7

    Camera {
        focus: true
    }
    \endqml

*/

/*!
    \internal
    \class QDeclarativeCamera
    \brief The QDeclarativeCamera class provides a camera item that you can add to a QDeclarativeView.
*/

QDeclarativeCamera::QDeclarativeCamera(QDeclarativeItem *parent) :
    QDeclarativeItem(parent),
    m_camera(0),
    m_viewfinderItem(0),
    m_viewfinderFramerate(0),
    m_imageSettingsChanged(false),
    m_pendingState(ActiveState),
    m_isStateSet(false),
    m_isValid(true),
    m_resourcesStatus(QDeclarativeCamera::ResourcesNotNeeded)
{
    m_videoSettings.setEncodingMode(QtMultimediaKit::ConstantQualityEncoding);

#if defined(Q_OS_SYMBIAN)
    RProcess thisProcess;
    if (!thisProcess.HasCapability(ECapabilityUserEnvironment)) {
        qmlInfo(this) << "Camera Element requires UserEnvironment Capability to be successfully used on Symbian";
	m_isValid = false;
	return;
    }
#endif
    m_camera = new QCamera(this);
    m_viewfinderItem = new QGraphicsVideoItem(this);
    m_viewfinderItem->setAspectRatioMode(Qt::KeepAspectRatioByExpanding);
    m_camera->setViewfinder(m_viewfinderItem);
    m_exposure = m_camera->exposure();
    m_focus = m_camera->focus();

#ifdef CUSTOM_RESOURCES
    m_cameraResources = new ResourcePolicy::ResourceSet("camera", this);
    m_cameraResources->setAlwaysReply();

    updateResources();

    connect(m_cameraResources, SIGNAL(resourcesGranted(const QList<ResourcePolicy::ResourceType>)), this, SLOT(_q_resourcesGranted(QList<ResourcePolicy::ResourceType>)));
    connect(m_cameraResources, SIGNAL(resourcesDenied()), this, SLOT(_q_resourcesDenied()));
    connect(m_cameraResources, SIGNAL(lostResources()), this, SLOT(_q_lostResources()));

#endif

    connect(m_viewfinderItem, SIGNAL(nativeSizeChanged(QSizeF)),
            this, SLOT(_q_nativeSizeChanged(QSizeF)));

    connect(m_camera, SIGNAL(lockStatusChanged(QCamera::LockStatus,QCamera::LockChangeReason)), this, SIGNAL(lockStatusChanged()));
    connect(m_camera, SIGNAL(stateChanged(QCamera::State)), this, SLOT(_q_updateState(QCamera::State)));
    connect(m_camera, SIGNAL(captureModeChanged(QCamera::CaptureMode)), this, SLOT(_q_updateMode(QCamera::CaptureMode)));
    connect(m_camera, SIGNAL(error(QCamera::Error)), this, SLOT(_q_cameraError(QCamera::Error)));

    m_capture = new QCameraImageCapture(m_camera, this);

    connect(m_capture, SIGNAL(imageCaptured(int,QImage)), this, SLOT(_q_imageCaptured(int, QImage)));
    connect(m_capture, SIGNAL(imageSaved(int,QString)), this, SLOT(_q_imageSaved(int, QString)));
    connect(m_capture, SIGNAL(error(int,QCameraImageCapture::Error,QString)),
            this, SLOT(_q_captureFailed(int,QCameraImageCapture::Error,QString)));

    m_recorder = new QMediaRecorder(m_camera, this);

    connect(m_recorder, SIGNAL(stateChanged(QMediaRecorder::State)), this, SLOT(_q_updateRecordingState(QMediaRecorder::State)));
    connect(m_recorder, SIGNAL(mutedChanged(bool)), this, SIGNAL(mutedChanged(bool)));
    connect(m_recorder, SIGNAL(durationChanged(qint64)), this, SIGNAL(durationChanged(qint64)));
    connect(m_recorder, SIGNAL(error(QMediaRecorder::Error)), this, SLOT(_q_recordFailed(QMediaRecorder::Error)));

    connect(m_focus, SIGNAL(focusZonesChanged()), this, SLOT(_q_updateFocusZones()));
    connect(m_camera, SIGNAL(lockStatusChanged(QCamera::LockType,QCamera::LockStatus,QCamera::LockChangeReason)),
            this, SLOT(_q_updateLockStatus(QCamera::LockType,QCamera::LockStatus,QCamera::LockChangeReason)));

    connect(m_exposure, SIGNAL(isoSensitivityChanged(int)), this, SIGNAL(isoSensitivityChanged(int)));
    connect(m_exposure, SIGNAL(apertureChanged(qreal)), this, SIGNAL(apertureChanged(qreal)));
    connect(m_exposure, SIGNAL(shutterSpeedChanged(qreal)), this, SIGNAL(shutterSpeedChanged(qreal)));

    //connect(m_exposure, SIGNAL(exposureCompensationChanged(qreal)), this, SIGNAL(exposureCompensationChanged(qreal)));

    connect(m_focus, SIGNAL(opticalZoomChanged(qreal)), this, SIGNAL(opticalZoomChanged(qreal)));
    connect(m_focus, SIGNAL(digitalZoomChanged(qreal)), this, SIGNAL(digitalZoomChanged(qreal)));
    connect(m_focus, SIGNAL(maximumOpticalZoomChanged(qreal)), this, SIGNAL(maximumOpticalZoomChanged(qreal)));
    connect(m_focus, SIGNAL(maximumDigitalZoomChanged(qreal)), this, SIGNAL(maximumDigitalZoomChanged(qreal)));

    //delayed start to evoid stopping the cammera immediately if
    //stop() is called after constructor,
    //or to set the rest of camera settings before starting the camera
    QMetaObject::invokeMethod(this, "_q_applyPendingState", Qt::QueuedConnection);
}

QDeclarativeCamera::~QDeclarativeCamera()
{
#ifdef CUSTOM_RESOURCES
    m_cameraResources->release();
#endif

    if (m_isValid) {
        m_camera->unload();

        delete m_viewfinderItem;
        delete m_recorder;
        delete m_capture;
        delete m_camera;
    }
}


QDeclarativeCamera::Error QDeclarativeCamera::error() const
{
    if (!m_isValid)
        return QDeclarativeCamera::CameraError;

    return QDeclarativeCamera::Error(m_camera->error());
}

QString QDeclarativeCamera::errorString() const
{
    if (!m_isValid)
        return QString();

    if(m_resourcesStatus == QDeclarativeCamera::ResourcesDenied)
        return QString(CAMERA_ERR_MSG_RESOURCES_RESERVED);

    return m_camera->errorString();
}

/*!
    \property QDeclarativeCamera::cameraMode
    \brief The current mode of the camera object.

    The default camera mode is StillCapture.
*/

QDeclarativeCamera::Mode QDeclarativeCamera::cameraMode() const
{
    return static_cast<QDeclarativeCamera::Mode>(m_camera->captureMode());
}

/*!
    \property QDeclarativeCamera::cameraState
    \brief The current state of the camera object.

    The default camera state is ActiveState.
*/

QDeclarativeCamera::State QDeclarativeCamera::cameraState() const
{
    if (!m_isValid)
        return QDeclarativeCamera::UnloadedState;

    return m_isStateSet ? QDeclarativeCamera::State(m_camera->state()) : m_pendingState;
}

/*!
  Start the camera.
*/
void QDeclarativeCamera::start()
{
    if (m_isValid)
        m_camera->start();
}

/*!
  Stop the camera.
*/
void QDeclarativeCamera::stop()
{
    if (m_isValid)
        m_camera->stop();
}

void QDeclarativeCamera::setCameraMode(QDeclarativeCamera::Mode mode)
{
    m_camera->setCaptureMode( static_cast<QCamera::CaptureMode>(mode) );

    // For some reason QCamera does not emit cameraModeChanged() signal
    // if it is in unloaded state.
    if(m_camera->state() ==  QCamera::UnloadedState)
        emit cameraModeChanged(static_cast<QDeclarativeCamera::Mode>(m_camera->captureMode()));

    updateResources();
}

void QDeclarativeCamera::setCameraState(QDeclarativeCamera::State state)
{
    if (!m_isValid)
        return;

    if (!m_isStateSet) {
        m_pendingState = state;
        return;
    }

    m_pendingState = state;

    QDeclarativeCamera::ResourcesStatus oldResStatus = m_resourcesStatus;

#ifndef CUSTOM_RESOURCES
    m_resourcesStatus = QDeclarativeCamera::ResourcesGranted;
#endif

    switch (state) {
    case QDeclarativeCamera::ActiveState:
    case QDeclarativeCamera::LoadedState:
        if( m_resourcesStatus == QDeclarativeCamera::ResourcesGranted) {
            if( state == QDeclarativeCamera::ActiveState) {
                m_camera->start();
            } else {
                m_camera->stop();
                m_camera->load();
            }
        } else if(m_resourcesStatus == QDeclarativeCamera::ResourcesNotNeeded) {
            m_resourcesStatus = QDeclarativeCamera::ResourcesAcquiring;
#ifdef CUSTOM_RESOURCES
            m_cameraResources->acquire();
#endif

        }
        // else: In case of ResourcesAcquiring and ResourcesDenied nothing needs to be
        //       done here. Camera is set to correct state in resourcesGranted() method.
        break;
    case QDeclarativeCamera::UnloadedState:
        m_camera->unload();
#ifdef CUSTOM_RESOURCES
        m_cameraResources->release();
#endif
        m_resourcesStatus = QDeclarativeCamera::ResourcesNotNeeded;
        break;
    }

    if(oldResStatus != m_resourcesStatus)
        emit resourcesStatusChanged(m_resourcesStatus);

}

/*!
    \property QDeclarativeCamera::lockStatus
    \brief The overall status for all the requested camera locks.
*/

QDeclarativeCamera::LockStatus QDeclarativeCamera::lockStatus() const
{
    if (!m_isValid)
        return QDeclarativeCamera::Unlocked;

    return QDeclarativeCamera::LockStatus(m_camera->lockStatus());
}

/*!
    \property QDeclarativeCamera::recordingState
    \brief The recording state of the camera in VideoCapture mode.
    If the camera is not in VideoCapture mode recordingState is
    always StoppedState.
*/

QDeclarativeCamera::RecordingState QDeclarativeCamera::recordingState() const
{
    if(!m_isValid)
        return QDeclarativeCamera::Stopped;

    return static_cast<QDeclarativeCamera::RecordingState>(m_recorder->state());
}

/*!
  Start focusing, exposure and white balance calculation.
  If the camera has keyboard focus,
  searchAndLock() is called automatically on camera focus button pressed.
*/
void QDeclarativeCamera::searchAndLock()
{
    if (m_isValid && m_camera->captureMode() == QCamera::CaptureStillImage)
        m_camera->searchAndLock();
}

/*!
  Unlock focus.

  If the camera has keyboard focus,
  unlock() is called automatically on camera focus button released.
 */
void QDeclarativeCamera::unlock()
{
    if (m_isValid)
        m_camera->unlock();
}

/*!
  Start image capture.
*/
void QDeclarativeCamera::captureImage()
{
    if (m_isValid && m_camera->captureMode() == QCamera::CaptureStillImage)
        m_capture->capture();
}

/*!
  Start/resume video recording.
*/
void QDeclarativeCamera::record()
{
    if (m_isValid && m_camera->captureMode() == QCamera::CaptureVideo) {
        m_recorder->record();

        if( m_capturedVideoPath != m_recorder->outputLocation().toString()) {
            m_capturedVideoPath = m_recorder->outputLocation().toString();
            emit capturedVideoPathChanged(m_capturedVideoPath);
        }
    }
}

/*!
  Pause video recording.
*/
void QDeclarativeCamera::pauseRecording()
{
    if (m_isValid && m_camera->captureMode() == QCamera::CaptureVideo)
        m_recorder->pause();
}

/*!
  Stop video recording.
*/
void QDeclarativeCamera::stopRecording()
{
    if (m_isValid && m_camera->captureMode() == QCamera::CaptureVideo)
        m_recorder->stop();
}

QImage QDeclarativeCamera::capturedImagePreview() const
{
    return m_capturedImagePreview;
}

QString QDeclarativeCamera::capturedImagePath() const
{
    return m_capturedImagePath;
}

QString QDeclarativeCamera::capturedVideoPath() const
{
    return m_capturedVideoPath;
}

void QDeclarativeCamera::paint(QPainter *, const QStyleOptionGraphicsItem *, QWidget *)
{
}

void QDeclarativeCamera::geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry)
{
    m_viewfinderItem->setSize(newGeometry.size());
    _q_updateFocusZones();

    QDeclarativeItem::geometryChanged(newGeometry, oldGeometry);
}

void QDeclarativeCamera::keyPressEvent(QKeyEvent * event)
{
    if (!m_isValid)
        return;

    switch (event->key()) {
    case Qt::Key_CameraFocus:

        // Check if usage of focus key is allowed
        if(m_resourcesStatus != QDeclarativeCamera::ResourcesGranted)
            return;

        if (m_camera->captureMode() == QCamera::CaptureStillImage) {
            if(m_camera->lockStatus() == QCamera::Unlocked)
                m_camera->searchAndLock();
            return;
        } else if (m_camera->captureMode() == QCamera::CaptureVideo) {
            if(m_recorder->state() == QMediaRecorder::PausedState)
                record();
            else if(m_recorder->state() == QMediaRecorder::RecordingState)
                pauseRecording();
            return;
        }
        break;
    case Qt::Key_Camera:
    case Qt::Key_WebCam:

        // Check if usage of camera key is allowed
        if(m_resourcesStatus != QDeclarativeCamera::ResourcesGranted)
            return;

        if (m_camera->captureMode() == QCamera::CaptureStillImage) {
            captureImage();
            return;
        } else if (m_camera->captureMode() == QCamera::CaptureVideo) {
            if(m_recorder->state() == QMediaRecorder::StoppedState)
                record();
            else
                stopRecording();
            return;
        }
        break;
    case Qt::Key_Zoom:
    case Qt::Key_ZoomIn:
    case Qt::Key_ZoomOut:
    case Qt::Key_F7:
    case Qt::Key_F8:
    case Qt::Key_VolumeUp:
    case Qt::Key_VolumeDown:
        // Check if usage of zoom keys is allowed
        if(m_resourcesStatus != QDeclarativeCamera::ResourcesGranted)
            return;
        break;
    }

    QDeclarativeItem::keyPressEvent(event);
}

void QDeclarativeCamera::keyReleaseEvent(QKeyEvent * event)
{
    if (!m_isValid)
        return;

    switch (event->key()) {
    case Qt::Key_CameraFocus:

        // Check if usage of focus key is allowed
        if( m_resourcesStatus != QDeclarativeCamera::ResourcesGranted)
            return;

        if (m_camera->captureMode() == QCamera::CaptureStillImage) {
            m_camera->unlock();
            return;
        }
        break;
    case Qt::Key_Camera:
    case Qt::Key_WebCam:

        // Check if usage of camera key is allowed
        if( m_resourcesStatus != QDeclarativeCamera::ResourcesGranted)
            return;

        if (m_camera->captureMode() == QCamera::CaptureStillImage)
            return;
        break;
    case Qt::Key_Zoom:
    case Qt::Key_ZoomIn:
    case Qt::Key_ZoomOut:
    case Qt::Key_F7:
    case Qt::Key_F8:
    case Qt::Key_VolumeUp:
    case Qt::Key_VolumeDown:
        // Check if usage of zoom keys is allowed
        if( m_resourcesStatus != QDeclarativeCamera::ResourcesGranted)
            return;
        break;
    }

    QDeclarativeItem::keyReleaseEvent(event);
}

QDeclarativeCamera::ExposureMode QDeclarativeCamera::exposureMode() const
{
    if (!m_isValid)
        return QDeclarativeCamera::ExposureAuto;

    return ExposureMode(m_exposure->exposureMode());
}

int QDeclarativeCamera::flashMode() const
{
    if (!m_isValid)
        return QDeclarativeCamera::FlashAuto;

    return m_exposure->flashMode();
}

void QDeclarativeCamera::setFlashMode(int mode)
{
    if (m_isValid && m_exposure->flashMode() != mode) {
        m_exposure->setFlashMode(QCameraExposure::FlashModes(mode));
        emit flashModeChanged(mode);
    }
}

qreal QDeclarativeCamera::exposureCompensation() const
{
    if (!m_isValid)
        return 0.0;

    return m_exposure->exposureCompensation();
}

void QDeclarativeCamera::setExposureCompensation(qreal ev)
{
    if (m_isValid)
        m_exposure->setExposureCompensation(ev);
}

int QDeclarativeCamera::isoSensitivity() const
{
    if (!m_isValid)
        return 0;

    return m_exposure->isoSensitivity();
}

qreal QDeclarativeCamera::shutterSpeed() const
{
    if (!m_isValid)
        return 0.0;

    return m_exposure->shutterSpeed();
}

qreal QDeclarativeCamera::aperture() const
{
    if (!m_isValid)
        return 0.0;

    return m_exposure->aperture();
}

void QDeclarativeCamera::setExposureMode(QDeclarativeCamera::ExposureMode mode)
{
    if (!m_isValid)
        return;

    if (exposureMode() != mode) {
        m_exposure->setExposureMode(QCameraExposure::ExposureMode(mode));
        emit exposureModeChanged(exposureMode());
    }
}

void QDeclarativeCamera::setManualIsoSensitivity(int iso)
{
    if (!m_isValid)
        return;

    m_exposure->setManualIsoSensitivity(iso);
}

QSize QDeclarativeCamera::captureResolution() const
{
    if (!m_isValid)
        return QSize();

    return m_imageSettings.resolution();
}

QSize QDeclarativeCamera::previewResolution() const
{
    if (!m_isValid)
        return QSize();

    return m_previewResolution;
}

QSize QDeclarativeCamera::videoCaptureResolution() const
{
    if (!m_isValid)
        return QSize();

    return m_videoSettings.resolution();
}

qreal QDeclarativeCamera::videoCaptureFramerate() const
{
    if (!m_isValid)
        return 0.0;

    return m_videoSettings.frameRate();
}

QDeclarativeCamera::VideoEncodingQuality QDeclarativeCamera::videoEncodingQuality() const
{
    if (!m_isValid)
        return QDeclarativeCamera::NormalQuality;

    return static_cast<QDeclarativeCamera::VideoEncodingQuality>(m_videoSettings.quality());
}

QSize QDeclarativeCamera::viewfinderResolution() const
{
    if (!m_isValid)
        return QSize();

    return m_viewfinderResolution;
}

qreal QDeclarativeCamera::viewfinderFramerate() const
{
    if (!m_isValid)
        return 0.0;

    return m_viewfinderFramerate;
}

void QDeclarativeCamera::setCaptureResolution(const QSize &resolution)
{
    if (m_isValid && m_imageSettings.resolution() != resolution) {
        m_imageSettings.setResolution(resolution);

        if (!m_imageSettingsChanged) {
            m_imageSettingsChanged = true;
            QMetaObject::invokeMethod(this, "_q_updateImageSettings", Qt::QueuedConnection);
        }

        emit captureResolutionChanged(resolution);
    }
}

void QDeclarativeCamera::setPreviewResolution(const QSize &resolution)
{
    if (m_isValid && m_previewResolution != resolution) {
        m_previewResolution = resolution;

        if (!m_imageSettingsChanged) {
            m_imageSettingsChanged = true;
            QMetaObject::invokeMethod(this, "_q_updateImageSettings", Qt::QueuedConnection);
        }

        emit previewResolutionChanged(resolution);
    }
}

void QDeclarativeCamera::setVideoCaptureResolution(const QSize &resolution)
{
    if (m_isValid && m_videoSettings.resolution() != resolution) {
        m_videoSettings.setResolution(resolution);

        if (!m_imageSettingsChanged) {
            m_imageSettingsChanged = true;
            QMetaObject::invokeMethod(this, "_q_updateImageSettings", Qt::QueuedConnection);
        }

        emit videoCaptureResolutionChanged(resolution);
    }
}

void QDeclarativeCamera::setVideoCaptureFramerate(qreal framerate)
{
    if (m_isValid && m_videoSettings.frameRate() != framerate) {
        m_videoSettings.setFrameRate(framerate);

        if (!m_imageSettingsChanged) {
            m_imageSettingsChanged = true;
            QMetaObject::invokeMethod(this, "_q_updateImageSettings", Qt::QueuedConnection);
        }

        emit videoCaptureFramerateChanged(framerate);
    }
}

void QDeclarativeCamera::setVideoEncodingQuality(QDeclarativeCamera::VideoEncodingQuality quality)
{
    if (m_isValid && m_videoSettings.quality() != static_cast<QtMultimediaKit::EncodingQuality>(quality)) {
        m_videoSettings.setQuality(static_cast<QtMultimediaKit::EncodingQuality>(quality));

        if (!m_imageSettingsChanged) {
            m_imageSettingsChanged = true;
            QMetaObject::invokeMethod(this, "_q_updateImageSettings", Qt::QueuedConnection);
        }

        emit videoEncodingQualityChanged(quality);
    }
}

void QDeclarativeCamera::setViewfinderResolution(const QSize &resolution)
{
    if (m_isValid && m_viewfinderResolution != resolution) {
        m_viewfinderResolution = resolution;

        if (!m_imageSettingsChanged) {
            m_imageSettingsChanged = true;
            QMetaObject::invokeMethod(this, "_q_updateImageSettings", Qt::QueuedConnection);
        }

        emit viewfinderResolutionChanged(resolution);
    }
}

void QDeclarativeCamera::setViewfinderFramerate(qreal framerate)
{
    if (m_isValid && m_viewfinderFramerate != framerate) {
        m_viewfinderFramerate = framerate;

        if (!m_imageSettingsChanged) {
            m_imageSettingsChanged = true;
            QMetaObject::invokeMethod(this, "_q_updateImageSettings", Qt::QueuedConnection);
        }

        emit viewfinderFramerateChanged(framerate);
    }
}

qreal QDeclarativeCamera::maximumOpticalZoom() const
{
    if (!m_isValid)
        return 0.0;

    return m_focus->maximumOpticalZoom();
}

qreal QDeclarativeCamera::maximumDigitalZoom() const
{
    if (!m_isValid)
        return 0.0;

    return m_focus->maximumDigitalZoom();
}

qreal QDeclarativeCamera::opticalZoom() const
{
    if (!m_isValid)
        return 0.0;

    return m_focus->opticalZoom();
}

qreal QDeclarativeCamera::digitalZoom() const
{
    if (!m_isValid)
        return 0.0;

    return m_focus->digitalZoom();
}

bool QDeclarativeCamera::isMuted() const
{
    if (!m_isValid)
        return true;

    return m_recorder->isMuted();
}
qint64 QDeclarativeCamera::duration() const
{
    if (!m_isValid)
        return 0;

    return m_recorder->duration();
}

QDeclarativeCamera::ResourcesStatus QDeclarativeCamera::resourcesStatus() const
{
    if (!m_isValid)
        return QDeclarativeCamera::ResourcesNotNeeded;

    return m_resourcesStatus;
}

void QDeclarativeCamera::setOpticalZoom(qreal value)
{
    if (m_isValid)
        m_focus->zoomTo(value, digitalZoom());
}

void QDeclarativeCamera::setDigitalZoom(qreal value)
{
    if (m_isValid)
        m_focus->zoomTo(opticalZoom(), value);
}

void QDeclarativeCamera::setMuted(bool muted)
{
    if (m_isValid)
        m_recorder->setMuted(muted);
}

QDeclarativeCamera::WhiteBalanceMode QDeclarativeCamera::whiteBalanceMode() const
{
    if (!m_isValid)
        return QDeclarativeCamera::WhiteBalanceAuto;

    return WhiteBalanceMode(m_camera->imageProcessing()->whiteBalanceMode());
}

int QDeclarativeCamera::manualWhiteBalance() const
{
    if (!m_isValid)
        return 0;

    return m_camera->imageProcessing()->manualWhiteBalance();
}

void QDeclarativeCamera::setWhiteBalanceMode(QDeclarativeCamera::WhiteBalanceMode mode) const
{
    if (m_isValid && whiteBalanceMode() != mode) {
        m_camera->imageProcessing()->setWhiteBalanceMode(QCameraImageProcessing::WhiteBalanceMode(mode));
        emit whiteBalanceModeChanged(whiteBalanceMode());
    }
}

void QDeclarativeCamera::setManualWhiteBalance(int colorTemp) const
{
    if (m_isValid && manualWhiteBalance() != colorTemp) {
        m_camera->imageProcessing()->setManualWhiteBalance(colorTemp);
        emit manualWhiteBalanceChanged(manualWhiteBalance());
    }
}

#ifdef CUSTOM_RESOURCES
void QDeclarativeCamera::_q_resourcesGranted(const QList<ResourcePolicy::ResourceType>& grantedOptionalResources)
{
    QDeclarativeCamera::ResourcesStatus oldStatus = m_resourcesStatus;

    m_resourcesStatus = QDeclarativeCamera::ResourcesGranted;

    if(m_camera->captureMode() == QCamera::CaptureVideo) {
        // Resources granted in video captured mode => video resources are available
        m_videoRecordingResourcesAvailable = true;
    } else {
        // In still capture mode video resources are granted when also all
        // optional resources are granted (video resources are requested as optional in still mode).
        if(grantedOptionalResources.count() == 3)
            m_videoRecordingResourcesAvailable = true;
        else
            m_videoRecordingResourcesAvailable = false;
    }

    switch (m_pendingState) {
    case QDeclarativeCamera::ActiveState:
        m_camera->start();
        break;
    case QDeclarativeCamera::LoadedState:
        m_camera->stop();
        m_camera->load();
        break;
    case QDeclarativeCamera::UnloadedState:
        m_resourcesStatus = QDeclarativeCamera::ResourcesNotNeeded;
        m_camera->unload();
        m_cameraResources->release();
        break;
    }

    if(oldStatus != m_resourcesStatus)
        emit resourcesStatusChanged(m_resourcesStatus);
}
#endif

#ifdef CUSTOM_RESOURCES
void QDeclarativeCamera::_q_resourcesDenied()
{
    m_videoRecordingResourcesAvailable = false;

    if( m_resourcesStatus != QDeclarativeCamera::ResourcesDenied) {
        m_resourcesStatus = QDeclarativeCamera::ResourcesDenied;
        emit resourcesStatusChanged(m_resourcesStatus);
    }

    m_camera->unload();
}
#endif

#ifdef CUSTOM_RESOURCES
void QDeclarativeCamera::_q_lostResources()
{
    _q_resourcesDenied();
}
#endif

void QDeclarativeCamera::updateResources()
{
#ifdef CUSTOM_RESOURCES
    QDeclarativeCamera::ResourcesStatus oldStatus = m_resourcesStatus;

    // Scale button reources for zooming
    m_cameraResources->addResource(ResourcePolicy::ScaleButtonType);

    // SnapButton resource for image/video capture
    m_cameraResources->addResource(ResourcePolicy::SnapButtonType);

    // VideoPlaybackType resource for rendering viewfinder and replays of captured videos
    m_cameraResources->addResource(ResourcePolicy::VideoPlaybackType);

    m_cameraResources->deleteResource(ResourcePolicy::AudioPlaybackType);
    m_cameraResources->deleteResource(ResourcePolicy::AudioRecorderType);
    m_cameraResources->deleteResource(ResourcePolicy::VideoRecorderType);

    if(m_camera->captureMode() == QCamera::CaptureVideo) {

        // AudioPlaybackType resource for playing replays of captured videos
        m_cameraResources->addResource(ResourcePolicy::AudioPlaybackType);

        // VideoRecorderType resource for capturing video
        m_cameraResources->addResource(ResourcePolicy::VideoRecorderType);

        // AudioRecorderType resource for capturing audio for videos
        m_cameraResources->addResource(ResourcePolicy::AudioRecorderType);

        if(m_videoRecordingResourcesAvailable && m_resourcesStatus != QDeclarativeCamera::ResourcesDenied)
            m_resourcesStatus = QDeclarativeCamera::ResourcesAcquiring;
        else
            m_resourcesStatus = QDeclarativeCamera::ResourcesDenied;

    } else {

        // In still mode resources needed only in video mode are added as optional
        // resources. In that way it is known whether video mode resources are
        // available when switching from still mode to video mode.

        ResourcePolicy::AudioResource* audioResource = new ResourcePolicy::AudioResource();
        audioResource->setOptional(true);
        m_cameraResources->addResourceObject(audioResource);

        ResourcePolicy::AudioRecorderResource* audioRecordResource = new ResourcePolicy::AudioRecorderResource();
        audioRecordResource->setOptional(true);
        m_cameraResources->addResourceObject(audioRecordResource);

        ResourcePolicy::VideoRecorderResource* videoRecordResource = new ResourcePolicy::VideoRecorderResource();
        videoRecordResource->setOptional(true);
        m_cameraResources->addResourceObject(videoRecordResource);

        if(m_resourcesStatus != QDeclarativeCamera::ResourcesDenied)
            m_resourcesStatus = QDeclarativeCamera::ResourcesAcquiring;
    }

    // No resources must be used untill new resources granted message is received
    m_camera->unload();

    if(oldStatus != m_resourcesStatus)
        emit resourcesStatusChanged(m_resourcesStatus);

    // This will trigger new resources granted message if/when resources are available
    m_cameraResources->update();
#endif
}

/*!
  \enum QDeclarativeCamera::LockStatus
    \value Unlocked
        The application is not interested in camera settings value.
        The camera may keep this parameter without changes, this is common with camera focus,
        or adjust exposure and white balance constantly to keep the viewfinder image nice.

    \value Searching
        The application has requested the camera focus, exposure or white balance lock with
        QCamera::searchAndLock(). This state indicates the camera is focusing or calculating exposure and white balance.

    \value Locked
        The camera focus, exposure or white balance is locked.
        The camera is ready to capture, application may check the exposure parameters.

        The locked state usually means the requested parameter stays the same,
        except of the cases when the parameter is requested to be constantly updated.
        For example in continuous focusing mode, the focus is considered locked as long
        and the object is in focus, even while the actual focusing distance may be constantly changing.
*/

/*!
    \enum QDeclarativeCamera::FlashMode

    \value FlashOff             Flash is Off.
    \value FlashOn              Flash is On.
    \value FlashAuto            Automatic flash.
    \value FlashRedEyeReduction Red eye reduction flash.
    \value FlashFill            Use flash to fillin shadows.
    \value FlashTorch           Constant light source, useful for focusing and video capture.
    \value FlashSlowSyncFrontCurtain
                                Use the flash in conjunction with a slow shutter speed.
                                This mode allows better exposure of distant objects and/or motion blur effect.
    \value FlashSlowSyncRearCurtain
                                The similar mode to FlashSlowSyncFrontCurtain but flash is fired at the end of exposure.
    \value FlashManual          Flash power is manualy set.
*/

/*!
    \enum QDeclarativeCamera::ExposureMode

    \value ExposureManual        Manual mode.
    \value ExposureAuto          Automatic mode.
    \value ExposureNight         Night mode.
    \value ExposureBacklight     Backlight exposure mode.
    \value ExposureSpotlight     Spotlight exposure mode.
    \value ExposureSports        Spots exposure mode.
    \value ExposureSnow          Snow exposure mode.
    \value ExposureBeach         Beach exposure mode.
    \value ExposureLargeAperture Use larger aperture with small depth of field.
    \value ExposureSmallAperture Use smaller aperture.
    \value ExposurePortrait      Portrait exposure mode.
    \value ExposureModeVendor    The base value for device specific exposure modes.
*/

QT_END_NAMESPACE

#include "moc_qdeclarativecamera_p.cpp"
