#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QQmlContext>
#include <QMediaPlaylist>
#include <QDir>
#include <QDirIterator>
#include <QFileInfo>
#include <QStandardPaths>
#include "qtquick2applicationviewer.h"

#include "playlistmodel.h"
#include "datadirectory.h"

void FillMediaList(QString myPath, PlaylistModel *queue);

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    PlaylistModel *playQueue = new PlaylistModel;
    QMediaPlaylist *playlist = new QMediaPlaylist;

    playQueue->setPlaylist(playlist);

    DataDirectory::initialize();

     FillMediaList("/home/mengcong/Pictures", playQueue);
    FillMediaList("/home/mengcong/Videos", playQueue);
    playQueue->setCurrentIndex(0);

    viewer.rootContext()->setContextProperty("playQueue", playQueue);
    viewer.setMainQmlFile(QStringLiteral("qml/testCallNemoThumbnailer/main.qml"));
    // viewer.setMainQmlFile(QStringLiteral("qml/testCallNemoThumbnailer/TestVideoThumbnail.qml"));
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
