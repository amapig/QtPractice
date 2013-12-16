#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include <QMediaPlaylist>
#include <QDir>
#include <QDirIterator>
#include <QFileInfo>
#include <QStandardPaths>
#include <QSortFilterProxyModel>

#include "qtquick2applicationviewer.h"

#include "playlistmodel.h"
#include "datadirectory.h"

#define GLOBAL_MOVIES_PATH "/home/mengcong/"
#define LOCAL_MOVIES_PATH "/home/mengcong/Videos"

// void FillMediaList(QString myPath, PlaylistModel *queue, bool isOther, bool isSearch, QString searchStr);

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;
    QSortFilterProxyModel *sfmodel = new QSortFilterProxyModel();

    // ------------Global begin----------
    PlaylistModel *globalPlayQueue = new PlaylistModel;
    QMediaPlaylist *globalPlaylist = new QMediaPlaylist;

    globalPlayQueue->setPlaylist(globalPlaylist);
    DataDirectory::initialize();

    globalPlayQueue->FillMediaList(LOCAL_MOVIES_PATH/*, globalPlayQueue*/, false, false, NULL);
    globalPlayQueue->setCurrentIndex(0);
    viewer.rootContext()->setContextProperty("globalPlayQueue", globalPlayQueue);

    //    sfmodel->setSourceModel(globalPlayQueue);
    //    viewer.rootContext()->setContextProperty("filterModel", sfmodel);
    // ------------Global end----------

    // ------------Global begin----------
    PlaylistModel *searchQueue = new PlaylistModel;
    QMediaPlaylist *searchList = new QMediaPlaylist;

    searchQueue->setPlaylist(searchList);

    DataDirectory::initialize();
    //searchQueue->FillMediaList(LOCAL_MOVIES_PATH, /*this, */false, true, "another");

    searchQueue->setCurrentIndex(0);
    viewer.rootContext()->setContextProperty("searchQueue", searchQueue);

    sfmodel->setSourceModel(searchQueue);
    viewer.rootContext()->setContextProperty("filterModel", sfmodel);
    // ------------Global end----------

    viewer.setSource(QUrl("qml/testSearchBox/main.qml"));
    // viewer.setSource(QUrl("qml/testSearchBox/SearchBar.qml"));
    viewer.showExpanded();

    return app.exec();
}

//void FillMediaList(QString myPath, PlaylistModel *queue, bool isOther, bool isSearch, QString searchStr)
//{
//    QDir dir(myPath);
//    QDirIterator walker(dir, QDirIterator::Subdirectories);

//    qDebug() << "FillMediaList::scan:" << myPath;

//    while (walker.hasNext())
//    {
//        QString file = walker.next();

//        qDebug() << "walker filepath: " << walker.filePath() << "walker next:" << file;

//        QFileInfo fInfo(file);

//        if (! fInfo.isHidden() && fInfo.isFile() && !fInfo.isDir() && fInfo.isReadable() &&
//                isSupport(fInfo))
//        {
//            if (isOther == true && walker.filePath().contains(LOCAL_MOVIES_PATH, Qt::CaseInsensitive))
//            {
//                qDebug() << "continue" << endl;
//                continue;
//            }

//            if (isSearch == true && !walker.filePath().contains(searchStr, Qt::CaseInsensitive)) {
//                qDebug() << "continue2" << endl;
//                continue;
//            }

//            qDebug() << "walker append file:" << file;
//            queue->append(file);
//        }
//    }
//    return;
//}
