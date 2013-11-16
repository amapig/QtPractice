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

#ifndef QDECLARATIVECAMERA_H
#define QDECLARATIVECAMERA_H

#include <QGraphicsVideoItem>
#include <QtCore/qbasictimer.h>
#include <QtDeclarative/qdeclarativeitem.h>
#include <QtCore/QTime>

#include <qcamera.h>
#include <qcameraimageprocessing.h>
#include <qcameraimagecapture.h>
#include <qmediarecorder.h>
#ifdef CUSTOM_RESOURCES
#include <policy/resource-set.h>
#endif



QT_BEGIN_HEADER

QT_BEGIN_NAMESPACE

class QTimerEvent;
class QVideoSurfaceFormat;


class QDeclarativeCamera : public QDeclarativeItem
{
    Q_OBJECT
    Q_PROPERTY(Mode cameraMode READ cameraMode WRITE setCameraMode NOTIFY cameraModeChanged)
    Q_PROPERTY(State cameraState READ cameraState WRITE setCameraState NOTIFY cameraStateChanged)
    Q_PROPERTY(LockStatus lockStatus READ lockStatus NOTIFY lockStatusChanged)
    Q_PROPERTY(RecordingState recordingState READ recordingState NOTIFY recordingStateChanged)
    Q_PROPERTY(QString errorString READ errorString NOTIFY errorChanged)
    Q_PROPERTY(Error error READ error NOTIFY errorChanged)

    Q_PROPERTY(QString capturedImagePath READ capturedImagePath NOTIFY imageSaved)
    Q_PROPERTY(QString capturedVideoPath READ capturedVideoPath NOTIFY capturedVideoPathChanged)

    Q_PROPERTY(int iso READ isoSensitivity WRITE setManualIsoSensitivity NOTIFY isoSensitivityChanged)
    Q_PROPERTY(qreal shutterSpeed READ shutterSpeed NOTIFY shutterSpeedChanged)
    Q_PROPERTY(qreal aperture READ aperture NOTIFY apertureChanged)
    Q_PROPERTY(qreal exposureCompensation READ exposureCompensation WRITE setExposureCompensation NOTIFY exposureCompensationChanged)

    Q_PROPERTY(ExposureMode exposureMode READ exposureMode WRITE setExposureMode NOTIFY exposureModeChanged)
    Q_PROPERTY(int flashMode READ flashMode WRITE setFlashMode NOTIFY flashModeChanged)
    Q_PROPERTY(WhiteBalanceMode whiteBalanceMode READ whiteBalanceMode WRITE setWhiteBalanceMode NOTIFY whiteBalanceModeChanged)
    Q_PROPERTY(int manualWhiteBalance READ manualWhiteBalance WRITE setManualWhiteBalance NOTIFY manualWhiteBalanceChanged)

    Q_PROPERTY(QSize captureResolution READ captureResolution WRITE setCaptureResolution NOTIFY captureResolutionChanged)
    Q_PROPERTY(QSize previewResolution READ previewResolution WRITE setPreviewResolution NOTIFY previewResolutionChanged)

    Q_PROPERTY(QSize videoCaptureResolution READ videoCaptureResolution WRITE setVideoCaptureResolution NOTIFY videoCaptureResolutionChanged)
    Q_PROPERTY(qreal videoCaptureFramerate READ videoCaptureFramerate WRITE setVideoCaptureFramerate NOTIFY videoCaptureFramerateChanged)
    Q_PROPERTY(VideoEncodingQuality videoEncodingQuality READ videoEncodingQuality WRITE setVideoEncodingQuality NOTIFY videoEncodingQualityChanged )

    Q_PROPERTY(QSize viewfinderResolution READ viewfinderResolution WRITE setViewfinderResolution NOTIFY viewfinderResolutionChanged)
    Q_PROPERTY(qreal viewfinderFramerate READ viewfinderFramerate WRITE setViewfinderFramerate NOTIFY viewfinderFramerateChanged)

    Q_PROPERTY(qreal opticalZoom READ opticalZoom WRITE setOpticalZoom NOTIFY opticalZoomChanged)
    Q_PROPERTY(qreal maximumOpticalZoom READ maximumOpticalZoom NOTIFY maximumOpticalZoomChanged)
    Q_PROPERTY(qreal digitalZoom READ digitalZoom WRITE setDigitalZoom NOTIFY digitalZoomChanged)
    Q_PROPERTY(qreal maximumDigitalZoom READ maximumDigitalZoom NOTIFY maximumDigitalZoomChanged)

    Q_PROPERTY(bool muted READ isMuted WRITE setMuted NOTIFY mutedChanged)
    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)

    Q_PROPERTY(ResourcesStatus resourcesStatus READ resourcesStatus NOTIFY resourcesStatusChanged)

    Q_ENUMS(Mode)
    Q_ENUMS(State)
    Q_ENUMS(LockStatus)
    Q_ENUMS(RecordingState)
    Q_ENUMS(Error)
    Q_ENUMS(FlashMode)
    Q_ENUMS(ExposureMode)
    Q_ENUMS(WhiteBalanceMode)
    Q_ENUMS(VideoEncodingQuality)
    Q_ENUMS(ResourcesStatus)
public:
    enum Mode
    {
        CaptureStillImage = QCamera::CaptureStillImage,
        CaptureVideo = QCamera::CaptureVideo
    };

    enum State
    {
        ActiveState = QCamera::ActiveState,
        LoadedState = QCamera::LoadedState,
        UnloadedState = QCamera::UnloadedState
    };

    enum LockStatus
    {
        Unlocked = QCamera::Unlocked,
        Searching = QCamera::Searching,
        Locked = QCamera::Locked
    };

    enum RecordingState
    {
        Stopped = QMediaRecorder::StoppedState,
        Recording = QMediaRecorder::RecordingState,
        Paused = QMediaRecorder::PausedState
    };

    enum Error
    {
        NoError = QCamera::NoError,
        CameraError = QCamera::CameraError,
        InvalidRequestError = QCamera::InvalidRequestError,
        ServiceMissingError = QCamera::ServiceMissingError,
        NotSupportedFeatureError = QCamera::NotSupportedFeatureError
    };

    enum FlashMode {
        FlashAuto = QCameraExposure::FlashAuto,
        FlashOff = QCameraExposure::FlashOff,
        FlashOn = QCameraExposure::FlashOn,
        FlashRedEyeReduction  = QCameraExposure::FlashRedEyeReduction,
        FlashFill = QCameraExposure::FlashFill,
        FlashTorch = QCameraExposure::FlashTorch,
        FlashSlowSyncFrontCurtain = QCameraExposure::FlashSlowSyncFrontCurtain,
        FlashSlowSyncRearCurtain = QCameraExposure::FlashSlowSyncRearCurtain,
        FlashManual = QCameraExposure::FlashManual
    };

    enum ExposureMode {
        ExposureAuto = 0,
        ExposureManual = 1,
        ExposurePortrait = 2,
        ExposureNight = 3,
        ExposureBacklight = 4,
        ExposureSpotlight = 5,
        ExposureSports = 6,
        ExposureSnow = 7,
        ExposureBeach = 8,
        ExposureLargeAperture = 9,
        ExposureSmallAperture = 10,
        ExposureModeVendor = 1000
    };

    enum WhiteBalanceMode {
        WhiteBalanceAuto = 0,
        WhiteBalanceManual = 1,
        WhiteBalanceSunlight = 2,
        WhiteBalanceCloudy = 3,
        WhiteBalanceShade = 4,
        WhiteBalanceTungsten = 5,
        WhiteBalanceFluorescent = 6,
        WhiteBalanceIncandescent = 7,
        WhiteBalanceFlash = 8,
        WhiteBalanceSunset = 9,
        WhiteBalanceVendor = 1000
    };

    enum VideoEncodingQuality
    {
        VeryLowQuality = QtMultimediaKit::VeryLowQuality,
        LowQuality = QtMultimediaKit::LowQuality,
        NormalQuality = QtMultimediaKit::NormalQuality,
        HighQuality = QtMultimediaKit::HighQuality,
        VeryHighQuality = QtMultimediaKit::VeryHighQuality
    };

    enum ResourcesStatus {
        ResourcesNotNeeded = 0,
        ResourcesAcquiring,
        ResourcesGranted,
        ResourcesDenied
    };

    QDeclarativeCamera(QDeclarativeItem *parent = 0);
    ~QDeclarativeCamera();

    Mode cameraMode() const;

    State cameraState() const;

    Error error() const;
    QString errorString() const;

    LockStatus lockStatus() const;

    RecordingState recordingState() const;

    QImage capturedImagePreview() const;
    QString capturedImagePath() const;
    QString capturedVideoPath() const;

    void paint(QPainter *, const QStyleOptionGraphicsItem *, QWidget *);

    int flashMode() const;
    ExposureMode exposureMode() const;
    qreal exposureCompensation() const;
    int isoSensitivity() const;
    qreal shutterSpeed() const;
    qreal aperture() const;

    WhiteBalanceMode whiteBalanceMode() const;
    int manualWhiteBalance() const;

    QSize captureResolution() const;
    QSize previewResolution() const;
    QSize videoCaptureResolution() const;
    qreal videoCaptureFramerate() const;
    VideoEncodingQuality videoEncodingQuality() const;
    QSize viewfinderResolution() const;
    qreal viewfinderFramerate() const;

    qreal maximumOpticalZoom() const;
    qreal maximumDigitalZoom() const;

    qreal opticalZoom() const;
    qreal digitalZoom() const;

    bool isMuted() const;
    qint64 duration() const;

    ResourcesStatus resourcesStatus() const;

public Q_SLOTS:
    void start();
    void stop();

    void setCameraMode(Mode mode);

    void setCameraState(State state);

    void searchAndLock();
    void unlock();

    void captureImage();

    void record();
    void pauseRecording();
    void stopRecording();

    void setFlashMode(int);
    void setExposureMode(QDeclarativeCamera::ExposureMode);
    void setExposureCompensation(qreal ev);
    void setManualIsoSensitivity(int iso);

    void setWhiteBalanceMode(QDeclarativeCamera::WhiteBalanceMode mode) const;
    void setManualWhiteBalance(int colorTemp) const;

    void setCaptureResolution(const QSize &size);
    void setPreviewResolution(const QSize &size);
    void setVideoCaptureResolution(const QSize &size);
    void setVideoCaptureFramerate(qreal framerate);
    void setVideoEncodingQuality(QDeclarativeCamera::VideoEncodingQuality quality);
    void setViewfinderResolution(const QSize &size);
    void setViewfinderFramerate(qreal framerate);

    void setOpticalZoom(qreal);
    void setDigitalZoom(qreal);

    void setMuted(bool);

Q_SIGNALS:
    void errorChanged();
    void error(QDeclarativeCamera::Error error, const QString &errorString);

    void cameraModeChanged(QDeclarativeCamera::Mode);

    void cameraStateChanged(QDeclarativeCamera::State);

    void lockStatusChanged();

    void recordingStateChanged(QDeclarativeCamera::RecordingState);

    void imageCaptured(const QString &preview);
    void imageSaved(const QString &path);
    void capturedVideoPathChanged(const QString &path);
    void captureFailed(const QString &message);


    void isoSensitivityChanged(int);
    void apertureChanged(qreal);
    void shutterSpeedChanged(qreal);
    void exposureCompensationChanged(qreal);
    void exposureModeChanged(QDeclarativeCamera::ExposureMode);
    void flashModeChanged(int);

    void whiteBalanceModeChanged(QDeclarativeCamera::WhiteBalanceMode) const;
    void manualWhiteBalanceChanged(int) const;

    void captureResolutionChanged(const QSize&);
    void previewResolutionChanged(const QSize&);
    void videoCaptureResolutionChanged(const QSize&);
    void videoCaptureFramerateChanged(qreal);
    void videoEncodingQualityChanged(QDeclarativeCamera::VideoEncodingQuality);
    void viewfinderResolutionChanged(const QSize&);
    void viewfinderFramerateChanged(qreal);

    void opticalZoomChanged(qreal);
    void digitalZoomChanged(qreal);
    void maximumOpticalZoomChanged(qreal);
    void maximumDigitalZoomChanged(qreal);

    void mutedChanged(bool);
    void durationChanged(qint64);

    void resourcesStatusChanged(ResourcesStatus);

protected:
    void geometryChanged(const QRectF &geometry, const QRectF &);
    void keyPressEvent(QKeyEvent * event);
    void keyReleaseEvent(QKeyEvent * event);

private Q_SLOTS:
    void _q_updateMode(QCamera::CaptureMode);
    void _q_updateState(QCamera::State);
    void _q_updateRecordingState(QMediaRecorder::State);
    void _q_nativeSizeChanged(const QSizeF &size);
    void _q_error(int, const QString &);
    void _q_cameraError(QCamera::Error);
    void _q_imageCaptured(int, const QImage&);
    void _q_imageSaved(int, const QString&);
    void _q_captureFailed(int, QCameraImageCapture::Error, const QString&);
    void _q_recordFailed(QMediaRecorder::Error);
    void _q_updateFocusZones();
    void _q_updateLockStatus(QCamera::LockType, QCamera::LockStatus, QCamera::LockChangeReason);
    void _q_updateImageSettings();
    void _q_applyPendingState();

#ifdef CUSTOM_RESOURCES
    // Resource Policy Framework callbacks
    void _q_resourcesGranted(const QList<ResourcePolicy::ResourceType>& grantedOptionalResources);
    void _q_resourcesDenied();
    void _q_lostResources();
#endif

private:

    void updateResources();

private:
    Q_DISABLE_COPY(QDeclarativeCamera)
    QCamera *m_camera;
    QGraphicsVideoItem *m_viewfinderItem;
    QMediaRecorder *m_recorder;

    QCameraExposure *m_exposure;
    QCameraFocus *m_focus;
    QCameraImageCapture *m_capture;

    QImage m_capturedImagePreview;
    QString m_capturedImagePath;
    QString m_capturedVideoPath;
    QList <QGraphicsItem*> m_focusZones;
    QTime m_focusFailedTime;

    QImageEncoderSettings m_imageSettings;
    QVideoEncoderSettings m_videoSettings;
    QSize m_previewResolution;
    QSize m_viewfinderResolution;
    qreal m_viewfinderFramerate;
    bool m_imageSettingsChanged;

    State m_pendingState;
    bool m_isStateSet;
    bool m_isValid;

#ifdef CUSTOM_RESOURCES
    ResourcePolicy::ResourceSet* m_cameraResources;
#endif
    ResourcesStatus m_resourcesStatus;
    bool m_videoRecordingResourcesAvailable;
};

QT_END_NAMESPACE

QML_DECLARE_TYPE(QT_PREPEND_NAMESPACE(QDeclarativeCamera))

QT_END_HEADER

#endif
