#ifndef ARTISTSSQLMODEL_H
#define ARTISTSSQLMODEL_H
#include <QSqlQueryModel>

#include "database.h"

class ArtistsSqlModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit ArtistsSqlModel(QObject *parent);
    void refresh();
    QVariant data(const QModelIndex &index, int role) const;

signals:

public slots:

private:
    const static char* COLUMN_NAMES[];
    const static char* SQL_SELECT;
};

//const char* ArtistsSqlModel::COLUMN_NAMES[] = {
//    "artist",
//    "title",
//    "year",
//    NULL
//};

//const char* ArtistsSqlModel::SQL_SELECT =
//        "SELECT artists.artist, albums.title, albums.year"
//        "  FROM albums"
//        "       JOIN artists ON albums.artistid = artists.id";

#endif // ARTISTSSQLMODEL_H
