#include "VideosDatabase.h"

VideosDatabase::VideosDatabase(QObject *parent)
    : QObject(parent)
    , myConnection(QSqlDatabase::addDatabase("QSQLITE"))
{
    init();
}

void VideosDatabase::init()
{
    myConnection.setDatabaseName("/home/skytree/Desktop/cmosvideoplayer.sqlite");
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
}

VideosDatabase::~VideosDatabase()
{
    myConnection.close();
}

void VideosDatabase::clear()
{
    QSqlQuery query(myConnection);
    if (query.exec("BEGIN TRANSACTION") &&
            query.exec("DELETE FROM videos") &&
            query.exec("END TRANSACTION"))
    {
        qDebug() << "Clear() successfully.";
    } else {
        qDebug() << "Clear() failed: "
                 << query.lastError();
    }
}

bool VideosDatabase::remove(QString filename)
{
    QSqlQuery query(myConnection);
    QString q = "DELETE FROM videos WHERE path = %1";
    if (! query.exec(q.arg(filename)))
    {
        qDebug() << "error: "
                 << query.lastError();
        return false;
    }
    return true;
}

void VideosDatabase::insertPosition(QString filename,
                                    int duration,
                                    int position,
                                    int lasttime)
{
    QSqlQuery query(myConnection);
    QString q = "INSERT INTO videos(path, duration, position, lasttime)"
            "VALUES('%1', %2, %3, %4)";
    if (!query.exec(q.arg(filename)
                    .arg(duration)
                    .arg(position)
                    .arg(lasttime)))
    {
        qDebug() << "error"
                 << q.arg(filename).arg(position)
                 << query.lastError();
    }
}

void VideosDatabase::insertLastTime(QString filename, int lasttime)
{
    QSqlQuery query(myConnection);
    QString q = "INSERT INTO videos(lasttime) WHERE path = %1"
            "VALUES(%2)";
    if (!query.exec(q.arg(filename).arg(lasttime)))
    {
        qDebug() << "error"
                 << q.arg(filename).arg(lasttime)
                 << query.lastError();
    }
}

void VideosDatabase::insertDuration(QString filename, int duration)
{
    QSqlQuery query(myConnection);
    QString q = "INSERT INTO videos(duration) WHERE path = %1"
            "VALUES(%2)";
    if (!query.exec(q.arg(filename).arg(duration)))
    {
        qDebug() << "error"
                 << q.arg(filename).arg(duration)
                 << query.lastError();
    }
}

int VideosDatabase::getPosition(QString filename)
{
    QSqlQuery query(myConnection);
    QString q = "SELECT position FROM videos"
            "WHERE path = %1";
    if (query.exec(q.arg(filename)))
    {
        while (query.next()) {
            int position = query.value(0).toInt();
            qDebug() << "position = " << position;
        }
    }
}

int VideosDatabase::getDuration(QString filename)
{
    QSqlQuery query(myConnection);
    QString q = "SELECT duration FROM videos"
            "WHERE path = %1";
    if (query.exec(q.arg(filename)))
    {
        while (query.next()) {
            int duration = query.value(0).toInt();
            qDebug() << "duration = " << duration;
        }
    }
}

int VideosDatabase::getLastTime(QString filename)
{
    QSqlQuery query(myConnection);
    QString q = "SELECT lasttime FROM videos"
            "WHERE path = %1";
    if (query.exec(q.arg(filename)))
    {
        while (query.next()) {
            int lasttime = query.value(0).toInt();
            qDebug() << "lasttime = " << lasttime;
        }
    }
}
