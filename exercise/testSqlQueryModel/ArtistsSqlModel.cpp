#include "ArtistsSqlModel.h"

const char* ArtistsSqlModel::COLUMN_NAMES[] = {
    "artist",
    "title",
    "year",
    NULL
};

const char* ArtistsSqlModel::SQL_SELECT =
        "SELECT artists.artist, albums.title, albums.year"
        "  FROM albums"
        "       JOIN artists ON albums.artistid = artists.id";


ArtistsSqlModel::ArtistsSqlModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    int idx = 0;
    QHash<int, QByteArray> roleNames;

    while( COLUMN_NAMES[idx]) {
        roleNames[Qt::UserRole + idx + 1] = COLUMN_NAMES[idx];
        idx++;
    }
    //setRoleNames(roleNames);

    refresh();

}

QVariant ArtistsSqlModel::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

void ArtistsSqlModel::refresh()
{
    this->setQuery(SQL_SELECT);
}


