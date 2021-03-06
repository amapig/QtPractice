#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QQmlContext>
#include <QMediaPlaylist>
#include <QDir>
#include <QDirIterator>
#include <QFileInfo>
#include <QStandardPaths>

#include "playlistmodel.h"
#include "datadirectory.h"
void FillMediaList(QString myPath, PlaylistModel *queue);

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    // ---------Copy begin--------

    //PlayQueue *playQueue = new PlayQueue;
    PlaylistModel *playQueue = new PlaylistModel;
    QMediaPlaylist *playlist = new QMediaPlaylist;

    playQueue->setPlaylist(playlist);

    //FillMediaList("/home/linmx/Music", playQueue);
    DataDirectory::initialize();
    // QString musicPath = QStandardPaths::writableLocation(QStandardPaths::MusicLocation);

    //FillMediaList(musicPath, playQueue);
    FillMediaList("/home/mengcong/Videos", playQueue);
    playQueue->setCurrentIndex(0);
    // player.setModel(playQueue);

    //    QGuiApplication::connect(playQueue, SIGNAL(itemChanged(QString)),
    //                          &player, SLOT(load(QString)));
    //    QGuiApplication::connect(&player, SIGNAL(eofReached()),
    //                          playQueue, SLOT(next()));

    // viewer.rootContext()->setContextProperty("player", &player);
    viewer.rootContext()->setContextProperty("playQueue", playQueue);

    // ---------Copy end--------

    viewer.setMainQmlFile(QStringLiteral("qml/testToolBar/main.qml"));
    viewer.showExpanded();

    return app.exec();
}

void FillMediaList(QString myPath, PlaylistModel *queue)
{
    QDir dir(myPath);
    QDirIterator walker(dir, QDirIterator::Subdirectories);

    qDebug() << "FillMediaList::scan:" << myPath;

    while (walker.hasNext())
    {
        QString file = walker.next();

        qDebug() << "walker next:" << file;

        QFileInfo fInfo(file);

        if (! fInfo.isHidden() && fInfo.isFile() && !fInfo.isDir() && fInfo.isReadable())
        {
            qDebug() << "walker append file:" << file;
            //queue->append(QUrl::fromLocalFile(fInfo.absoluteFilePath()));
            queue->append(file);
        }
    }
    return;
}
