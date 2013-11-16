#include "qmlcamerasettings.h"

#include <QSizeF>

#include "qdeclarativecamera_p.h"


#include <QDebug>


#define WB_MODE_KEY "wb-mode"
#define FLASH_MODE_KEY "flash-mode"
#define EXPOSURE_COMPENSATION_KEY "exposure-compensation"
#define CAPTURE_RESOLUTION_KEY "capture-resolution"
#define VIDEO_CAPTURE_RESOLUTION_KEY "video-capture-resolution"
#define VIEWFINDER_RESOLUTION_KEY "viewfinder-resolution"
#define VIDEO_ENCODING_QUALITY_KEY "video-encoding-quality"
#define CAMERA_MODE_KEY "camera-mode"

QmlCameraSettings::QmlCameraSettings(QObject *parent) :
    QSettings(parent)
{
}

int QmlCameraSettings::whiteBalanceMode() const
{
    return value(WB_MODE_KEY, QVariant(QDeclarativeCamera::WhiteBalanceAuto)).toInt();
}

int QmlCameraSettings::flashMode() const
{
    return value(FLASH_MODE_KEY, QVariant(QDeclarativeCamera::FlashAuto)).toInt();
}

qreal QmlCameraSettings::exposureCompensation() const
{
    return value(EXPOSURE_COMPENSATION_KEY, QVariant(0.0)).toReal();
}

QVariant QmlCameraSettings::captureResolution() const
{
    return value(CAPTURE_RESOLUTION_KEY, QVariant(QSizeF()));
}

QVariant QmlCameraSettings::videoCaptureResolution() const
{
    return value(VIDEO_CAPTURE_RESOLUTION_KEY, QVariant(QSizeF()));
}

QVariant QmlCameraSettings::viewfinderResolution() const
{
    return value(VIEWFINDER_RESOLUTION_KEY, QVariant(QSizeF()));
}

int QmlCameraSettings::videoEncodingQuality() const
{
    return value(VIDEO_ENCODING_QUALITY_KEY, QVariant(0)).toInt();
}

int QmlCameraSettings::cameraMode() const
{
    return value(CAMERA_MODE_KEY, QVariant(QDeclarativeCamera::CaptureStillImage)).toInt();
}

void QmlCameraSettings::setWhiteBalanceMode(int wb)
{
    setValue(WB_MODE_KEY, wb);
    emit whiteBalanceModeChanged(wb);
}

void QmlCameraSettings::setFlashMode(int flash)
{
    setValue(FLASH_MODE_KEY, flash);
    emit flashModeChanged(flash);
}

void QmlCameraSettings::setExposureCompensation(qreal exposure)
{
    setValue(EXPOSURE_COMPENSATION_KEY, exposure);
    emit exposureCompensationChanged(exposure);
}

void QmlCameraSettings::setCaptureResolution(QVariant reso)
{
    setValue(CAPTURE_RESOLUTION_KEY, reso);
    emit captureResolutionChanged(reso);
}

void QmlCameraSettings::setVideoCaptureResolution(QVariant reso)
{
    setValue(VIDEO_CAPTURE_RESOLUTION_KEY, reso);
    emit videoCaptureResolutionChanged(reso);
}

void QmlCameraSettings::setViewfinderResolution(QVariant reso)
{
    setValue(VIEWFINDER_RESOLUTION_KEY, reso);
    emit viewfinderResolutionChanged(reso);
}

void QmlCameraSettings::setVideoEncodingQuality(int quality)
{
    setValue(VIDEO_ENCODING_QUALITY_KEY, quality);
    emit videoEncodingQualityChanged(quality);
}

void QmlCameraSettings::setCameraMode(int mode)
{
    setValue(CAMERA_MODE_KEY, mode);
    emit cameraModeChanged(mode);
}
