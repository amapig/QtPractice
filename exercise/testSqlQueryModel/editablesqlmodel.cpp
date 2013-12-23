#include <QtSql>

#include "editablesqlmodel.h"

EditableSqlModel::EditableSqlModel(QObject *parent)
    : QSqlQueryModel(parent),
      myConnection(QSqlDatabase::addDatabase("QSQLITE"))
{
    createConnection();
}

bool EditableSqlModel::createConnection()
{
    myConnection.setDatabaseName("/home/mengcong/Desktop/cmosvideoplayer.sqlite");
    bool isOK = myConnection.open();
    if (!isOK) {
        qDebug() << "open DB failed." << endl;
    }
    QSqlQuery query(myConnection);
    QStringList queries;
    queries << "CREATE TABLE IF NOT EXISTS videos ("
               "  path       TEXT,"
               "  duration   INT,"
               "  position   INT,"
               "  lasttime   INT"
               ")";

    queries << "CREATE INDEX IF NOT EXISTS idx_videos_path "
               "ON videos(path)";

    queries << "CREATE INDEX IF NOT EXISTS idx_videos_duration "
               "ON videos(duration)";

    queries << "CREATE INDEX IF NOT EXISTS idx_videos_position "
               "ON videos(position)";

    queries << "CREATE INDEX IF NOT EXISTS idx_videos_lasttime "
               "ON videos(lasttime)";

    foreach (QString q, queries)
    {
        qDebug() << "executing statement:" << q;
        if (! query.exec(q))
        {
            qDebug() << "failed to execute query:" << query.lastError();
            break;
        } else {
            qDebug() << "exectuing successfully." << endl;
        }
    }

    //    db.setDatabaseName("/home/mengcong/Desktop/mengcong.sqlite");
    //    if (!db.open()) {
    //        qDebug() << "open db failed" << endl;
    //        return false;
    //    }

    //    QSqlQuery query;
    //    query.exec("create table person (id int primary key, "
    //               "firstname varchar(20), lastname varchar(20))");
    //    query.exec("insert into person values(101, 'Danny', 'Young')");
    //    query.exec("insert into person values(102, 'Christine', 'Holand')");
    //    query.exec("insert into person values(103, 'Lars', 'Gordon')");
    //    query.exec("insert into person values(104, 'Roberto', 'Robitaille')");
    //    query.exec("insert into person values(105, 'Maria', 'Papadopoulos')");

    //    query.exec("create table items (id int primary key,"
    //               "imagefile int,"
    //               "itemtype varchar(20),"
    //               "description varchar(100))");
    //    query.exec("insert into items "
    //               "values(0, 0, 'Qt',"
    //               "'Qt is a full development framework with tools designed to "
    //               "streamline the creation of stunning applications and  "
    //               "amazing user interfaces for desktop, embedded and mobile "
    //               "platforms.')");
    //    query.exec("insert into items "
    //               "values(1, 1, 'Qt Quick',"
    //               "'Qt Quick is a collection of techniques designed to help "
    //               "developers create intuitive, modern-looking, and fluid "
    //               "user interfaces using a CSS & JavaScript like language.')");
    //    query.exec("insert into items "
    //               "values(2, 2, 'Qt Creator',"
    //               "'Qt Creator is a powerful cross-platform integrated "
    //               "development environment (IDE), including UI design tools "
    //               "and on-device debugging.')");
    //    query.exec("insert into items "
    //               "values(3, 3, 'Qt Project',"
    //               "'The Qt Project governs the open source development of Qt, "
    //               "allowing anyone wanting to contribute to join the effort "
    //               "through a meritocratic structure of approvers and "
    //               "maintainers.')");

    //    query.exec("create table images (itemid int, file varchar(20))");
    //    query.exec("insert into images values(0, 'images/qt-logo.png')");
    //    query.exec("insert into images values(1, 'images/qt-quick.png')");
    //    query.exec("insert into images values(2, 'images/qt-creator.png')");
    //    query.exec("insert into images values(3, 'images/qt-project.png')");

    return true;
}

Qt::ItemFlags EditableSqlModel::flags(
        const QModelIndex &index) const
{
    Qt::ItemFlags flags = QSqlQueryModel::flags(index);
    if (index.column() == 1 || index.column() == 2)
        flags |= Qt::ItemIsEditable;
    return flags;
}

bool EditableSqlModel::setData(const QModelIndex &index, const QVariant &value, int /* role */)
{
    Q_UNUSED(role);

    emit dataChanged(index, index);
    return true;
}

void EditableSqlModel::refresh()
{
    setQuery("select * from videos");
}

bool EditableSqlModel::insertMetadata(QString path, int duration, int position, int lasttime)
{
    QSqlQuery query(myConnection);
    QString q = "insert into videos(path, duration, position, lasttime)"
            "values('%1', %2, %3, %4)";
    if (!query.exec(q.arg(path)
                    .arg(duration)
                    .arg(position)
                    .arg(lasttime)))
    {
        qDebug() << "error"
                 << q.arg(path).arg(position)
                 << query.lastError();
        return false;
    }
    return true;
}

bool EditableSqlModel::removeMetadata(QString path)
{
    QSqlQuery query(myConnection);
    QString q = "delete from videos where path = '%1'";
    if (!query.exec(q.arg(path)))
    {
        qDebug() << "error"
                 << q.arg(path)
                 << query.lastError();
        return false;
    }
    return true;
}

bool EditableSqlModel::updateLastTime(QString path, int lasttime)
{
    QSqlQuery query(myConnection);
    query.prepare("update videos set lasttime = ? where path = ?");
    query.addBindValue(lasttime);
    query.addBindValue(path);
    return query.exec();
}

bool EditableSqlModel::updatePosition(QString path, int position)
{
    QSqlQuery query(myConnection);
    query.prepare("update videos set position = ? where path = ?");
    query.addBindValue(position);
    query.addBindValue(path);
    return query.exec();
}
