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


#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>
#include <QMap>
#include <QString>

#include "playqueue.h"
#include <QMediaPlayer>
#include <QMediaMetaData>
#include "playlistmodel.h"
#include <QFileInfo>

class Player : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool isPlaying
               READ isPlaying
               NOTIFY isPlayingChanged);
    Q_PROPERTY(int position
               READ position
               WRITE seek
               NOTIFY positionChanged);
    Q_PROPERTY(int duration
               READ duration
               NOTIFY durationChanged);
    Q_PROPERTY(int volume
               READ volume
               WRITE setVolume
               NOTIFY volumeChanged);
    Q_PROPERTY(QString uri
               READ currentUrl
               NOTIFY urlChanged);
    Q_PROPERTY(QString artist
               READ artist
               NOTIFY artistChanged);
    Q_PROPERTY(QString title
               READ title
               NOTIFY titleChanged);
    Q_PROPERTY(QString name
               READ name
               NOTIFY nameChanged);

public:
    explicit Player(QObject *parent = 0);
    ~Player();


    Q_INVOKABLE void loadPath(QString path);
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void next();
    Q_INVOKABLE void playIndex(int nPos);//used only when mediacontent is playlist
    void seek(int millisecs);
    void setVolume(int vol);
    int volume();

    void setModel(PlaylistModel* que);
    int duration() ;
    int position() ;
    int isPlaying() ;


signals:
    void urlChanged(QMediaContent);
    void titleChanged(QString);
    void artistChanged(QString);
    void nameChanged(QString);
    void isPlayingChanged();
    void positionChanged(qint64 pos);
    void durationChanged(qint64 duration);
    void volumeChanged(int vol);
    void errorOccured(QMediaPlayer::Error err, QString message);
    void eofReached();

public:
    QString currentUrl() {
        return m_pMediaPlayer->media().canonicalUrl().toString();
    }


private:
    void inhibitStandby();
    void uninhibitStandby();

    quint32 myInhibitionCookie;
    QString myUri;
    bool myIsPlaying;
    qint64 myDuration;
    qint64 myPosition;
    int myVolume;
    QMediaPlayer *m_pMediaPlayer;

public slots:
    void load(QString url)
    {
        loadPath(url);
    }
    QString albumImagPath(){
        QUrl url = m_pMediaPlayer->metaData(QMediaMetaData::CoverArtUrlLarge).value<QUrl>();
        return url.toString();
    }
    QString artist(){
        QString artist = m_pMediaPlayer->metaData(QMediaMetaData::Author).toString();
        if(artist.isEmpty())
            return "Unknown";
        else
            return artist;
    }
    QString title(){
        QString title =  m_pMediaPlayer->metaData(QMediaMetaData::Title).toString();
        if(title.isEmpty())
            return name();//"Unknown";
        else
            return title;
    }
    QString name(){
        QString filepath = m_pMediaPlayer->currentMedia().canonicalUrl().toLocalFile();
        return QFileInfo(filepath).completeBaseName();
    }

private slots:
    void handleMediaStatusChanged(QMediaPlayer::MediaStatus mediaStatus);
    void handleStateChanged(QMediaPlayer::State state);
    void handlePositionChanged(qint64 pos);
    void handleVolumeChanged(int vol);
    void handleCurMediaChanged(QMediaContent mc);
};

#endif // PLAYER_H
