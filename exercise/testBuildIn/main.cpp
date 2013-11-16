#include <QtGui/QGuiApplication>
#include <qqml.h>
#include "cplusplus2qml.h"
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Message>("com.mycompany.messaging", 1, 0, "Message");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/testBuildIn/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
