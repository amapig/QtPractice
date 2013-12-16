#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

#include <QQmlProperty>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    QQmlEngine engine;
    QQmlComponent component(&engine, QUrl::fromLocalFile("qml/Playing/Player.qml"));
    QObject *object = component.create();

    viewer.rootContext()->setContextProperty("player", object);

    viewer.setMainQmlFile(QStringLiteral("qml/Playing/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
