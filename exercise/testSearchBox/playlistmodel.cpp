
/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
#include <QFileInfo>
#include <QUrl>
#include <QMediaPlaylist>
#include <QMediaPlayer>

#include "playlistmodel.h"

PlaylistModel::PlaylistModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_playlist(0)
    , m_searchlist(0)
{
}

int PlaylistModel::rowCount(const QModelIndex &parent) const
{
    return m_playlist && !parent.isValid() ? m_playlist->mediaCount() : 0;
}

int PlaylistModel::columnCount(const QModelIndex &parent) const
{
    return !parent.isValid() ? ColumnCount : 0;
}

QModelIndex PlaylistModel::index(int row, int column, const QModelIndex &parent) const
{
    return m_playlist && !parent.isValid()
            && row >= 0 && row < m_playlist->mediaCount()
            && column >= 0 && column < ColumnCount
            ? createIndex(row, column)
            : QModelIndex();
}

QModelIndex PlaylistModel::parent(const QModelIndex &child) const
{
    Q_UNUSED(child);

    return QModelIndex();
}

QHash<int, QByteArray> PlaylistModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[ArtistRole] = "artist";
    roles[AlbumRole] = "album";
    roles[CoverRole] = "cover";
    return roles;
}

void PlaylistModel::append(QString url)
{

    if(m_playlist->addMedia(QUrl::fromLocalFile(url)))
    {
        //        MediaInfo* pMI = new MediaInfo(url);
        //        myFiles.append(pMI);
    }
}

void PlaylistModel::remove(int nPos)
{
    m_playlist->removeMedia(nPos);
    //    MediaInfo* pMI = myFiles.at(nPos);
    //    myFiles.removeAt(nPos);
    //    delete pMI;
}

bool isSupport(QFileInfo fInfo)
{
    if( fInfo.suffix().toLower() == "3gp" ||
            fInfo.suffix().toLower() == "mp4" )
    {
        return true;
    }

    return false;
}

void PlaylistModel::FillMediaList(QString myPath,/* PlaylistModel *queue,*/ bool isOther, bool isSearch, QString searchStr)
{
    QDir dir(myPath);
    QDirIterator walker(dir, QDirIterator::Subdirectories);

    qDebug() << "FillMediaList::scan:" << myPath;

    while (walker.hasNext())
    {
        QString file = walker.next();

        qDebug() << "walker filepath: " << walker.filePath() << "walker next:" << file;

        QFileInfo fInfo(file);

        if (! fInfo.isHidden() && fInfo.isFile() && !fInfo.isDir() && fInfo.isReadable() &&
                isSupport(fInfo))
        {
            if (isOther == true && walker.filePath().contains("/home/mengcong/Videos", Qt::CaseInsensitive))
            {
                qDebug() << "continue" << endl;
                continue;
            }

            if (isSearch == true && !walker.filePath().contains(searchStr, Qt::CaseInsensitive)) {
                qDebug() << "continue2" << endl;
                continue;
            }

            qDebug() << "walker append file:" << file;
            append(file);
        }
    }
    return;
}

void PlaylistModel::previous()
{
    if(m_playlist)
        m_playlist->previous();
}

void PlaylistModel::next()
{
    if(m_playlist)
        m_playlist->next();
}

QVariant PlaylistModel::data(const QModelIndex &index, int role) const
{
    QFileInfo fi(m_playlist->media(index.row()).canonicalUrl().toLocalFile());
    fi.fileName();

    switch (role)
    {
    case Qt::DisplayRole:
        return QVariant();
    case NameRole:
        return QVariant(fi.fileName());
    default:
        return QVariant();
    }
}

QMediaPlaylist *PlaylistModel::playlist() const
{
    return m_playlist;
}

void PlaylistModel::setPlaylist(QMediaPlaylist *playlist)
{
    if (m_playlist) {
        disconnect(m_playlist, SIGNAL(mediaAboutToBeInserted(int,int)), this, SLOT(beginInsertItems(int,int)));
        disconnect(m_playlist, SIGNAL(mediaInserted(int,int)), this, SLOT(endInsertItems()));
        disconnect(m_playlist, SIGNAL(mediaAboutToBeRemoved(int,int)), this, SLOT(beginRemoveItems(int,int)));
        disconnect(m_playlist, SIGNAL(mediaRemoved(int,int)), this, SLOT(endRemoveItems()));
        disconnect(m_playlist, SIGNAL(mediaChanged(int,int)), this, SLOT(changeItems(int,int)));
    }

    beginResetModel();
    m_playlist = playlist;

    if (m_playlist) {
        connect(m_playlist, SIGNAL(mediaAboutToBeInserted(int,int)), this, SLOT(beginInsertItems(int,int)));
        connect(m_playlist, SIGNAL(mediaInserted(int,int)), this, SLOT(endInsertItems()));
        connect(m_playlist, SIGNAL(mediaAboutToBeRemoved(int,int)), this, SLOT(beginRemoveItems(int,int)));
        connect(m_playlist, SIGNAL(mediaRemoved(int,int)), this, SLOT(endRemoveItems()));
        connect(m_playlist, SIGNAL(mediaChanged(int,int)), this, SLOT(changeItems(int,int)));
    }

    endResetModel();
}

bool PlaylistModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Q_UNUSED(role);
    m_data[index] = value;
    emit dataChanged(index, index);
    return true;
}

void PlaylistModel::beginInsertItems(int start, int end)
{
    m_data.clear();
    qDebug()<<"beginInsertItems:start:"<<start<<" endat:"<<end;
    beginInsertRows(QModelIndex(), start, end);
}

void PlaylistModel::endInsertItems()
{
    endInsertRows();
}

void PlaylistModel::beginRemoveItems(int start, int end)
{
    m_data.clear();
    beginRemoveRows(QModelIndex(), start, end);
}

void PlaylistModel::endRemoveItems()
{
    endInsertRows();
}

void PlaylistModel::changeItems(int start, int end)
{
    m_data.clear();
    emit dataChanged(index(start,0), index(end,ColumnCount));
}
