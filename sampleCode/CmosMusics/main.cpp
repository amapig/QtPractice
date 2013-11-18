#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include "qtquick2applicationviewer.h"
#include <QMediaPlaylist>
#include <QDir>
#include <QDirIterator>
#include <QFileInfo>
#include <QStandardPaths>

#include "src/player.h"
#include "src/playqueue.h"
#include "src/playlistmodel.h"
#include "src/datadirectory.h"
void FillMediaList(QString myPath, PlaylistModel *queue);

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    Player player;

    qDebug() << "setting up playing queue";
    //PlayQueue *playQueue = new PlayQueue;
    PlaylistModel *playQueue = new PlaylistModel;
    QMediaPlaylist *playlist = new QMediaPlaylist;

    playQueue->setPlaylist(playlist);

    //FillMediaList("/home/linmx/Music", playQueue);
    DataDirectory::initialize();
    QString musicPath = QStandardPaths::writableLocation(QStandardPaths::MusicLocation);


    //FillMediaList(musicPath, playQueue);
    FillMediaList("/home/mengcong/Music/mp3", playQueue);
    playQueue->setCurrentIndex(0);
    player.setModel(playQueue);
/*
    QGuiApplication::connect(playQueue, SIGNAL(itemChanged(QString)),
                          &player, SLOT(load(QString)));
                          */
    QGuiApplication::connect(&player, SIGNAL(eofReached()),
                          playQueue, SLOT(next()));

    viewer.rootContext()->setContextProperty("player", &player);
    viewer.rootContext()->setContextProperty("playQueue", playQueue);

    viewer.setSource(QUrl("qrc:/qml/qml/main.qml"));
    viewer.setBaseSize(QSize(800,600));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
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
