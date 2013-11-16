#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include "qtquick2applicationviewer.h"

#include "StopWatch.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer view;
    view.rootContext()->setContextProperty("stopwatch", new Stopwatch);

    view.setSource(QUrl::fromLocalFile("qml/testQmlCallCPlusPlus/main.qml"));
    view.show();

    return app.exec();
}
