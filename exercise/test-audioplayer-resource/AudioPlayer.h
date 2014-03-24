#ifndef AUDIOPLAYER_H
#define AUDIOPLAYER_H

#include <QObject>
#include <QMap>
#include <QString>

#include <QMediaPlayer>
#include <QMediaMetaData>
#include <QFileInfo>

class AudioPlayer : public QObject
{
    Q_OBJECT

public:
    explicit AudioPlayer(QObject *parent = 0);
    ~AudioPlayer();

    Q_INVOKABLE void setDataSource(QString path);
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void stop();
    Q_INVOKABLE bool isPlaying();

private:
    void inhibitStandby();
    void uninhibitStandby();

    bool myIsPlaying;
    QMediaPlayer *m_pMediaPlayer;

private slots:
    void handleStateChanged(QMediaPlayer::State state);
};

#endif // AUDIOPLAYER_H
