/* This file is part of mediabox-core
 * Copyright (C) 2011 Martin Grimme  <martin.grimme _AT_ gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */


#include "player.h"
#include <QUrl>
#include <QDBusInterface>
#include <QDBusReply>
#include <QDBusMessage>
#include <QDebug>

Player::Player(QObject *parent)
    : QObject(parent)
    , myIsPlaying(false)
    , myDuration(0)
    , myPosition(0)
    , myVolume(50)

{
    m_pMediaPlayer = new QMediaPlayer;

    connect(m_pMediaPlayer, SIGNAL(positionChanged(qint64)),
            this, SLOT(handlePositionChanged(qint64)));

    connect(m_pMediaPlayer, SIGNAL(durationChanged(qint64)),
            this, SIGNAL(durationChanged(qint64)));

    connect(m_pMediaPlayer, SIGNAL(stateChanged(QMediaPlayer::State)),
            this, SLOT(handleStateChanged(QMediaPlayer::State)));

    connect(m_pMediaPlayer, SIGNAL(mediaStatusChanged(QMediaPlayer::MediaStatus)),
            this, SLOT(handleMediaStatusChanged(QMediaPlayer::MediaStatus)));

    connect(m_pMediaPlayer, SIGNAL(volumeChanged(int)),
            this, SLOT(handleVolumeChanged(int)));
    /*
    connect(m_pMediaPlayer, SIGNAL(mediaChanged(QMediaContent)),
                                  this, SIGNAL(urlChanged(QMediaContent)));
*/
    connect(m_pMediaPlayer, SIGNAL(currentMediaChanged(QMediaContent)), this, SLOT(handleCurMediaChanged(QMediaContent)));

    m_pMediaPlayer->setVolume(100);
}

Player::~Player()
{
    delete m_pMediaPlayer;
}

/* Inhibits the device from entering standby mode.
 */
void Player::inhibitStandby()
{
    qDebug() << "inhibiting standby";
    QDBusInterface inhibitor("org.freedesktop.PowerManagement",
                             "/org/freedesktop/PowerManagement/Inhibit",
                             "org.freedesktop.PowerManagement.Inhibit");
    QDBusReply<quint32> reply = inhibitor.call("Inhibit", "MusicShelf",
                                               "Playing Music");
    qDebug() << "reply:" << reply << reply.isValid();
    qDebug() << "error:" << reply.error();

    if (reply.isValid())
    {
        myInhibitionCookie = reply.value();
        qDebug() << "inhibitor cookie:" << reply.value();
    }
}

/* Allows the device to enter standby mode.
 */
void Player::uninhibitStandby()
{
    qDebug() << "allowing standby";
    QDBusInterface inhibitor("org.freedesktop.PowerManagement",
                             "/org/freedesktop/PowerManagement/Inhibit",
                             "org.freedesktop.PowerManagement.Inhibit");
    QDBusReply<bool> hasInhibit = inhibitor.call("HasInhibit");
    qDebug() << "have inhibit" << hasInhibit;
    if (hasInhibit)
    {
        qDebug() << "uninhibiting with cookie" << myInhibitionCookie;
        inhibitor.call("UnInhibit", myInhibitionCookie);
    }
    hasInhibit = inhibitor.call("HasInhibit");
    qDebug() << "have inhibit" << hasInhibit;
}


void Player::loadPath(QString path)
{
    qDebug() << "Player::loadPath:" << path;
    //m_pMediaPlayer->setVolume(myVolume);
    m_pMediaPlayer->setMedia(QUrl::fromLocalFile(path));
    m_pMediaPlayer->play();
    myUri = path;
}


void Player::setModel(PlaylistModel* que)
{
    m_pMediaPlayer->setPlaylist(que->playlist());
}

void Player::play()
{
    m_pMediaPlayer->play();
}

void Player::pause()
{    
    if (myIsPlaying)
        m_pMediaPlayer->pause();
    else
        m_pMediaPlayer->play();
}

void Player::stop()
{
    m_pMediaPlayer->stop();
}

void Player::previous()
{
    m_pMediaPlayer->playlist()->next();
    //m_pMediaPlayer->play();
}

void Player::next()
{
    m_pMediaPlayer->playlist()->previous();
}

void Player::playIndex(int nPos)
{
    m_pMediaPlayer->playlist()->setCurrentIndex(nPos);
    m_pMediaPlayer->play();
}

void Player::seek(int millisecs)
{    
    m_pMediaPlayer->setPosition(millisecs);
    emit positionChanged(millisecs);
}

void Player::setVolume(int vol)
{    
    m_pMediaPlayer->setVolume(100);
    myVolume = vol;
    emit volumeChanged(vol);
}

int Player::volume()
{
    return myVolume;
}


int Player::duration()
{
    if(m_pMediaPlayer)
        return m_pMediaPlayer->duration();
    else
        return 0;
}

int Player::position()
{
    if(m_pMediaPlayer)
        return m_pMediaPlayer->position();
    else
        return 0;
}

int Player::isPlaying()
{
    return myIsPlaying;
}

void Player::handleStateChanged(QMediaPlayer::State state)
{
    switch (state)
    {
    case QMediaPlayer::StoppedState:
        qDebug() << "[STOPPED]";
        myIsPlaying = false;
        emit isPlayingChanged();
        break;
    case QMediaPlayer::PlayingState:
        qDebug() << "[PLAYING]";
        myIsPlaying = true;
        emit isPlayingChanged();
        break;
    case QMediaPlayer::PausedState:
        qDebug() << "[PAUSED]";
        myIsPlaying = false;
        emit isPlayingChanged();
        break;
    }
}
void Player::handleCurMediaChanged(QMediaContent mc)
{
    qDebug() << "[handleCurMediaChanged:]" << mc.canonicalUrl().toLocalFile();
    QString artist = m_pMediaPlayer->metaData(QMediaMetaData::Author).toString();
    QString title = m_pMediaPlayer->metaData(QMediaMetaData::Title).toString();
    emit urlChanged(mc);
    emit artistChanged(artist);
    emit titleChanged(title);
    emit nameChanged(title);
}

void Player::handleMediaStatusChanged(QMediaPlayer::MediaStatus mediaStatus)
{
    switch (mediaStatus)
    {
    case QMediaPlayer::EndOfMedia:
        emit eofReached();
        break;
    case QMediaPlayer::LoadedMedia:
        myDuration = m_pMediaPlayer->duration();
        break;
    default:
        break;
    }
}

void Player::handlePositionChanged(qint64 pos)
{
    if (pos != myPosition)
    {
        myPosition = pos;
        emit positionChanged(pos);
    }
}

void Player::handleVolumeChanged(int vol)
{
    myVolume = vol;
    emit volumeChanged(vol);
}
