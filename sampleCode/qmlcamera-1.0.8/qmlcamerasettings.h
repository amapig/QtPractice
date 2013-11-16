#ifndef QMLCAMERASETTINGS_H
#define QMLCAMERASETTINGS_H

#include <QSettings>

class QmlCameraSettings : public QSettings
{
    Q_OBJECT
    Q_PROPERTY(int whiteBalanceMode READ whiteBalanceMode WRITE setWhiteBalanceMode NOTIFY whiteBalanceModeChanged)
    Q_PROPERTY(int flashMode READ flashMode WRITE setFlashMode NOTIFY flashModeChanged)
    Q_PROPERTY(qreal exposureCompensation READ exposureCompensation WRITE setExposureCompensation NOTIFY exposureCompensationChanged)
    Q_PROPERTY(QVariant captureResolution READ captureResolution WRITE setCaptureResolution NOTIFY captureResolutionChanged)
    Q_PROPERTY(QVariant videoCaptureResolution READ videoCaptureResolution WRITE setVideoCaptureResolution NOTIFY videoCaptureResolutionChanged)
    Q_PROPERTY(QVariant viewfinderResolution READ viewfinderResolution WRITE setViewfinderResolution NOTIFY viewfinderResolutionChanged)
    Q_PROPERTY(int videoEncodingQuality READ videoEncodingQuality WRITE setVideoEncodingQuality NOTIFY videoEncodingQualityChanged)
    Q_PROPERTY(int cameraMode READ cameraMode WRITE setCameraMode NOTIFY cameraModeChanged )
public:
    explicit QmlCameraSettings(QObject *parent = 0);

    int whiteBalanceMode() const;
    int flashMode() const;
    qreal exposureCompensation() const;
    QVariant captureResolution() const;
    QVariant videoCaptureResolution() const;
    QVariant viewfinderResolution() const;
    int videoEncodingQuality() const;
    int cameraMode() const;

signals:

    void whiteBalanceModeChanged(int);
    void flashModeChanged(int);
    void exposureCompensationChanged(qreal);
    void captureResolutionChanged(QVariant);
    void videoCaptureResolutionChanged(QVariant);
    void viewfinderResolutionChanged(QVariant);
    void videoEncodingQualityChanged(int);
    void cameraModeChanged(int);

public slots:

    void setWhiteBalanceMode(int);
    void setFlashMode(int);
    void setExposureCompensation(qreal);
    void setCaptureResolution(QVariant);
    void setVideoCaptureResolution(QVariant);
    void setViewfinderResolution(QVariant);
    void setVideoEncodingQuality(int);
    void setCameraMode(int);

};

#endif // QMLCAMERASETTINGS_H
