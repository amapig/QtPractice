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


#ifndef MEDIA_INFO_H
#define MEDIA_INFO_H

#include <QSharedPointer>
#include <QString>
#include <QDebug>
#include <QMap>
#include "tags.h"

/* Lightweight object representing a single unit of content. File objects are
 * moved around as shared pointers, so that they get deleted automatically
 * when falling out of scope everywhere.
 * Do not derive from this class as it's final.
 */
//typedef QMap<QString, QVariant> Metadata;

class MediaInfo
{
public:
    //typedef QSharedPointer<content::File> Ptr;

    enum Type { INVALID, FOLDER, FILE };
    //Type type() const { return myType; }
    MediaInfo(Type type = INVALID);
    MediaInfo(QString path);
    ~MediaInfo();

    void print(){
        qDebug()<<"Media Info name="<<myName<<" !artist:"<<myArtist<<" !Album"<<myAlbum;
    }

    QString name() const { return myName; }
    void setName(QString name) { myName = name; }

    QString artist() const { return myArtist; }
    void setArtist(QString artist) { myArtist = artist; }

    qint64 duration() const { return myDuration; }
    void setDuration(qint64 duration) { myDuration = duration; }

    QString path() const { return myPath; }
    void setPath(QString path) { myPath = path; }

    QString album() const { return myAlbum; }
    void setAlbum(QString album) { myAlbum = album; }

    QString image() const { return myImage; }
    void setImage(QString image) { myImage = image; }
/*
    int index() const { return myIndex; }
    void setIndex(int index) { myIndex = index; }
*/
    bool operator<(MediaInfo &other) { return myIndex < other.myIndex; }
    void inspectFile(QString path);

private:        
    Type myType;
    QString myName;
    QString myArtist;
    QString myPath;
    QString myAlbum;
    QString myPreview;
    QString myImage;
    qint64 myDuration;

    int myIndex;
    QString getCover(QString path, QString album, tags::Tags tags);
};


#endif // MEDIA_INFO_H
