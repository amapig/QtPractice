#include "playlistmodel.h"

#include <QFileInfo>
#include <QUrl>
#include <QMediaPlaylist>
#include <QMediaPlayer>

PlaylistModel::PlaylistModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_playlist(0)
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
//    MediaInfo* pMI = myFiles.at(nPos);
//    myFiles.removeAt(nPos);
//    delete pMI;
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

QString PlaylistModel::getImgPath(int index)
{
//    MediaInfo *fptr = myFiles.at(index);
//    if(fptr)
//        return fptr->image();
//    else
        return "";
}


QVariant PlaylistModel::data(const QModelIndex &index, int role) const
{
    //MediaInfo *fptr = myFiles.at(index.row());
    qDebug()<<"PlaylistModel::data:"<<index.row()<<" role="<<role; // <<" count = "<<myFiles.count();
    //fptr->print();

    QFileInfo fi(m_playlist->media(index.row()).canonicalUrl().toLocalFile());
    fi.fileName();

    switch (role)
    {
    case Qt::DisplayRole:
        return QVariant();
    case NameRole:
        //return QVariant(fptr->name());
        return QVariant(fi.fileName());
//    case ArtistRole:
//        return QVariant(fptr->artist());
//    case AlbumRole:
//        return QVariant(fptr->album());
//    case CoverRole:
//        return QVariant(fptr->image());
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
