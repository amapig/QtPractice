#include "AudioPlayer.h"
#include <QUrl>
#include <QDebug>

AudioPlayer::AudioPlayer(QObject *parent)
    : QObject(parent),
      myIsPlaying(false)
{
    m_pMediaPlayer = new QMediaPlayer;

    connect(m_pMediaPlayer, SIGNAL(stateChanged(QMediaPlayer::State)),
            this, SLOT(handleStateChanged(QMediaPlayer::State)));
}

AudioPlayer::~AudioPlayer()
{
    delete m_pMediaPlayer;
}

void AudioPlayer::setDataSource(QString path)
{
    qDebug() << "Player::loadPath:" << path;
    m_pMediaPlayer->setMedia(QUrl::fromLocalFile(path));
    m_pMediaPlayer->play();
}

void AudioPlayer::play()
{
    qDebug() << "AudioPlayer::play" << m_pMediaPlayer->currentMedia().canonicalUrl().toLocalFile();
    m_pMediaPlayer->play();
}

void AudioPlayer::pause()
{
    if (myIsPlaying)
        m_pMediaPlayer->pause();
    else
        m_pMediaPlayer->play();
}

void AudioPlayer::stop()
{
    qDebug()<<__FUNCTION__;
    m_pMediaPlayer->stop();
}

bool AudioPlayer::isPlaying()
{
    return myIsPlaying;
}

void AudioPlayer::handleStateChanged(QMediaPlayer::State state)
{
    switch (state)
    {
    case QMediaPlayer::StoppedState:
        qDebug() << "[STOPPED]";
        myIsPlaying = false;
        break;
    case QMediaPlayer::PlayingState:
        qDebug() << "[PLAYING]";
        myIsPlaying = true;
        break;
    case QMediaPlayer::PausedState:
        qDebug() << "[PAUSED]";
        myIsPlaying = false;
        break;
    }
}
