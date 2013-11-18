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


#include "mediaInfo.h"
#include <QDebug>
#include <QMediaPlayer>
#include <QMediaMetaData>
#include <QFileInfo>
#include <QDir>
#include <QCryptographicHash>
#include "datadirectory.h"

MediaInfo::MediaInfo(Type type)
    : myType(type)
    , myIndex(0)
{
    //qDebug() << "creating file object" << this;
}

MediaInfo::MediaInfo(QString path)
{

    //TODO:can't obtain the metadata via QMeidaPlayer.
    /*
    QMediaPlayer mp;
    mp.setMedia(QUrl::fromLocalFile(path));
    QStringList result = mp.availableMetaData();
    foreach (const QString &str, result) {
        qDebug()<<"availableMetaData: "<<str;
    }

    setAlbum((mp.metaData(QMediaMetaData::AlbumTitle)).toString());
    setName(mp.metaData(QMediaMetaData::Title).toString());
    setArtist(mp.metaData(QMediaMetaData::Author).toString());
    setImage(mp.metaData(QMediaMetaData::CoverArtUrlSmall).toString());
    setDuration(mp.duration());
    setPath(path);
    //setIndex(mp.metaData(QMediaMetaData::AlbumArtist).toString());
    */

    inspectFile(path);
    print();
}

MediaInfo::~MediaInfo()
{
    //qDebug() << "deleting file object" << this << "representing" << name();
}

void MediaInfo::inspectFile(QString path)
{
    QFileInfo f(path);

    tags::Tags tags(path);

    QByteArray title;
    QByteArray album;
    QByteArray artist;
    QString cover;
    int index = 0;

    if (tags.contains("TITLE"))
        title = tags.get("TITLE").replace('/', '|');
    else
        title = f.completeBaseName().toUtf8();

    if (tags.contains("ALBUM"))
        album = tags.get("ALBUM").replace('/', '|');
    else
        album = f.dir().dirName().toUtf8();

    if (tags.contains("ARTIST"))
        artist = tags.get("ARTIST").replace('/', '|');
    else
        artist = "Unknown Artist";

    if (tags.contains("TRACKNUMBER"))
    {
        QList<QByteArray> parts = tags.get("TRACKNUMBER").split('/');
        index = parts[0].toInt();
    }

    setName(title);
    setAlbum(album);
    setArtist(artist);

    // is there cover art available?
    cover = getCover(path, album, tags);
    setImage(cover);
}


QString MediaInfo::getCover(QString path, QString album, tags::Tags tags )
{

    if (tags.contains("PICTURE") && ! tags.get("PICTURE").isEmpty())
    {
        QByteArray coverKey = album.toUtf8();
        QByteArray md5 = QCryptographicHash::hash(coverKey,
                                                  QCryptographicHash::Md5);
        QFile coverFile(DataDirectory::Covers + "/" + QString(md5.toHex()) + ".jpg");
        if (! coverFile.exists() && coverFile.open(QIODevice::WriteOnly))
        {
            coverFile.write(tags.get("PICTURE"));
            coverFile.close();
        }
        return coverFile.fileName();
    }
    else
    {
        QFileInfo f(path);
        QDir folder = f.dir();
        QStringList filters;
        filters << "*.jpg" << "*.jpeg" << "*.png";
        folder.setNameFilters(filters);

        foreach (QString f, folder.entryList(filters))
        {
            return folder.path() + "/" + f;
        }
    }
}
