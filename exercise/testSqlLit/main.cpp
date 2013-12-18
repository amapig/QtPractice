#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QQmlContext>
#include <QtSql>
#include "VideosDatabase.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    VideosDatabase *db = new VideosDatabase;
    viewer.rootContext()->setContextProperty("videosDB", db);

    viewer.setMainQmlFile(QStringLiteral("qml/app/qtquick20/main.qml")); // MAINQML
    viewer.showFullScreen();

    return app.exec();
}

//#include <QtCore/QCoreApplication>
//#include <QSqlDatabase>
//#include <QSqlQuery>
//#include <QSqlError>
//#include <QDebug>
//#include <QStringList>

//int main(int argc, char *argv[])
//{
//    QCoreApplication a(argc, argv);
//    qDebug()<<"Available drivers:";
//    QStringList drivers = QSqlDatabase::drivers();
//    foreach(QString driver, drivers) {
//        qDebug() << "\t" << driver;
//    }

//    qDebug()<<"1111111111111";
//    QSqlDatabase myConnection = QSqlDatabase::addDatabase("QSQLITE");
//    myConnection.setDatabaseName("/home/skytree/Desktop/cmosvideoplayer.sqlite");
//    bool isOK = myConnection.open();
//    qDebug()<<"2222222222222";
//    if (isOK) {
//        qDebug() << "open DB successfully." << endl;
//    } else {
//        qDebug() << "open DB failed." << endl;
//    }

//    QSqlQuery query(myConnection);
//    QStringList queries;
//    queries << "CREATE TABLE IF NOT EXISTS videos ("
//               "  path       TEXT,"
//               "  duration   FLOAT,"
//               "  position   FLOAT,"
//               "  lasttime   FLOAT"
//               ")";

//    queries << "CREATE INDEX IF NOT EXISTS idx_videos_path "
//               "ON videos(path)";

//    queries << "CREATE INDEX IF NOT EXISTS idx_videos_duration "
//               "ON videos(duration)";

//    queries << "CREATE INDEX IF NOT EXISTS idx_videos_position "
//               "ON videos(position)";

//    queries << "CREATE INDEX IF NOT EXISTS idx_videos_lasttime "
//               "ON videos(lasttime)";

//    foreach (QString q, queries)
//    {
//        qDebug() << "executing statement:" << q;
//        if (! query.exec(q))
//        {
//            qDebug() << "failed to execute query:" << query.lastError();
//            break;
//        } else {
//            qDebug() << "exectuing successfully." << endl;
//        }
//    }

//    return a.exec();
//}
