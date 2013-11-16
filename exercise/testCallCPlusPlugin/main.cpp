#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    //viewer.setMainQmlFile(QStringLiteral("qml/testCallCPlusPlugin/main.qml"));
    viewer.setSource(QUrl("qrc:/qml/testCallCPlusPlugin/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
