#ifndef PLAYLISTMODEL_H
#define PLAYLISTMODEL_H

#include <QAbstractItemModel>
#include <QAbstractListModel>
#include <QMediaPlaylist>
#include <QDir>
#include <QDirIterator>

#define GLOBAL_MOVIES_PATH "/home/skytree/"
#define LOCAL_MOVIES_PATH "/home/skytree/Videos"

class PlaylistModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged);
public:
    enum Column
    {
        Title = 0,
        ColumnCount
    };

    enum {
        NameRole = Qt::UserRole+1,
        ArtistRole,
        AlbumRole,
        CoverRole
    };

    PlaylistModel(QObject *parent = 0);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;

    QModelIndex index(int row, int column, const QModelIndex &parent = QModelIndex()) const;
    QModelIndex parent(const QModelIndex &child) const;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    QMediaPlaylist *playlist() const;
    void setPlaylist(QMediaPlaylist *playlist);

    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::DisplayRole);

    QHash<int, QByteArray> roleNames() const;

public:
    Q_INVOKABLE void append(QString url);
    Q_INVOKABLE void remove(int nPos);
    Q_INVOKABLE QString getPath(int nPos);

signals:
    void currentIndexChanged(int);

public slots:
    int currentIndex();
    void setCurrentIndex(int idx);

    int getCount();
    void fillMediaList(QString myPath,
                       bool isOther,
                       bool isSearch,
                       QString searchStr);
    void clear();

    // For multi operation.
    bool isMultiSelected(int nPos);
    void addSelected(int nPos);
    void removeSelected(int nPos);
    void clearSelected();
    void deleteSelected();

private slots:
    void beginInsertItems(int start, int end);
    void endInsertItems();
    void beginRemoveItems(int start, int end);
    void endRemoveItems();
    void changeItems(int start, int end);

private:
    QMediaPlaylist *m_playlist;
    QMap<QModelIndex, QVariant> m_data;
    QVector<int> m_selectarray;

    bool isSupport(QFileInfo fInfo);
};

#endif // PLAYLISTMODEL_H
