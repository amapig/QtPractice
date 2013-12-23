#ifndef EDITABLESQLMODEL_H
#define EDITABLESQLMODEL_H

#include <QSqlQueryModel>

class EditableSqlModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    EditableSqlModel(QObject *parent = 0);

    Qt::ItemFlags flags(const QModelIndex &index) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);

public slots:
    void refresh();
    bool insertMetadata(QString path,
                   int duration,
                   int position,
                   int lasttime);
    bool removeMetadata(QString path);
    bool updatePosition(QString path, int position);
    bool updateLastTime(QString path, int lasttime);

private:
    bool createConnection();
    QSqlDatabase myConnection;
};

#endif
