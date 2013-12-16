#include <QFileInfo>
#include <QUrl>
#include <QMediaPlaylist>
#include <QMediaPlayer>

#include "playlistmodel.h"

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
    m_playlist->addMedia(QUrl::fromLocalFile(url));
}

// TODO: Remove from m_playlist.
void PlaylistModel::remove(int nPos)
{
    qDebug() << "m_playlist remove: " << nPos;
    m_playlist->removeMedia(nPos);
}

void PlaylistModel::clear()
{
    m_playlist->clear();
}

QString PlaylistModel::getPath(int nPos)
{
    if(nPos >=0 && nPos < m_playlist->mediaCount())
        return m_playlist->media(nPos).canonicalUrl().toLocalFile();
}

int PlaylistModel::currentIndex()
{
    return m_playlist->currentIndex();
}

void PlaylistModel::setCurrentIndex(int idx)
{
    m_playlist->setCurrentIndex(idx);
    emit currentIndexChanged(idx);
}

int PlaylistModel::getCount()
{
    return m_playlist->mediaCount();
}

bool PlaylistModel::isSupport(QFileInfo fInfo)
{
    if( fInfo.suffix().toLower() == "3gp" ||
            fInfo.suffix().toLower() == "mp4" ) {
        return true;
    }
    return false;
}

void PlaylistModel::fillMediaList(QString myPath, bool isOther, bool isSearch, QString searchStr)
{
    QDir dir(myPath);
    QDirIterator walker(dir, QDirIterator::Subdirectories);

    qDebug() << "FillMediaList::scan:" << myPath;

    while (walker.hasNext())
    {
        QString file = walker.next();
        qDebug() << "walker filepath: " << walker.filePath() << "walker next:" << file;
        QFileInfo fInfo(file);

        if (! fInfo.isHidden() && fInfo.isFile() && !fInfo.isDir() &&
                fInfo.isReadable() && isSupport(fInfo))
        {
            if (isOther == true && walker.filePath().contains(LOCAL_MOVIES_PATH, Qt::CaseInsensitive))
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
    qDebug() << "****beginInsertItems:start:" << start << " endat:" << end << "****";

//    m_data.clear();
//    qDebug()<<"beginInsertItems:start:"<<start<<" endat:"<<end;
    beginInsertRows(QModelIndex(), start, end);
    emit dataChanged(start, end);
}

void PlaylistModel::endInsertItems()
{
      qDebug() << "****endInsertItems****" << endl;
    endInsertRows();
}

void PlaylistModel::beginRemoveItems(int start, int end)
{
    qDebug() <<"****beginRemoveItems****" << endl;
//    m_data.clear();
    beginRemoveRows(QModelIndex(), start, end);
    emit dataChanged(start, end);
}

void PlaylistModel::endRemoveItems()
{
    qDebug() <<"****endRemoveItems****" << endl;
    endInsertRows();
}

void PlaylistModel::changeItems(int start, int end)
{
    qDebug() << "****changeItems****" << endl;
//    m_data.clear();
//    emit dataChanged(index(start,0), index(end,ColumnCount));
}

// For multi operation.
bool PlaylistModel::isMultiSelected(int nPos)
{
    if(m_selectarray.contains(nPos)) {
        qDebug() << "return true" << endl;
        return true;
    }
    qDebug() << "return false" << endl;
    return false;
}

void PlaylistModel::addSelected(int nPos)
{
    qDebug() << "add selected" << nPos << endl;
    m_selectarray.append(nPos);

    return;
}

void PlaylistModel::removeSelected(int nPos)
{
    qDebug() << "remove selected" << nPos << endl;
    for (int i = 0; i < m_selectarray.count(); i++) {
        if (m_selectarray.value(i) == nPos) {
            m_selectarray.remove(i);
            break;
        }
    }

    return;
}

void PlaylistModel::clearSelected()
{
    qDebug() << "clear select array" << endl;
    m_selectarray.clear();

    return;
}

void PlaylistModel::deleteSelected()
{
    for(int i = 0; i < m_selectarray.count(); i++) {
        qDebug() << "delete selected" << m_selectarray.value(i) << endl;
        QFile::remove(getPath(m_selectarray.value(i)));
        remove(m_selectarray.value(i));
    }

    clearSelected();

    return;
}
