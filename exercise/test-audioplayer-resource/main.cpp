#include <QtGui/QGuiApplication>
#include <QQmlContext>

#include <policy/resource-set.h>
#include <policy/resource.h>
// #include <resources.h>
// #include <audio-resource.h>

#include "qtquick2applicationviewer.h"

#include "AudioPlayer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // ResourcePolicy::ResourceSet* mySet = new ResourcePolicy::ResourceSet("player");
    ResourcePolicy::ResourceSet* mySet = new ResourcePolicy::ResourceSet("player");
    mySet->addResource(AudioPlaybackType);
    mySet->addResource(VideoPlaybackType);

    QObject::connect(
                mySet,
                SIGNAL(resourcesGranted(QList<ResourcePolicy::ResourceType>)),
                this,
                SLOT(acquireOkHandler(QList<ResourcePolicy::Resource>))
                );
    QObject::connect(mySet, SIGNAL(resourcesDenied()), this, SLOT(acquireDeniedHandler()));
    mySet->acquire();

    QtQuick2ApplicationViewer viewer;
    AudioPlayer audioPlayer;
    viewer.rootContext()->setContextProperty("audioPlayer", &audioPlayer);

    viewer.setMainQmlFile(QStringLiteral("qml/app/qtquick20/main.qml")); // MAINQML
    viewer.showFullScreen();

    return app.exec();
}
