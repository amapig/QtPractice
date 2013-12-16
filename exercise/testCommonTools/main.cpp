#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    // viewer.setMainQmlFile(QStringLiteral("qml/testCommonTools/Cmos_Practice/main.qml"));
    viewer.setMainQmlFile(QStringLiteral("qml/testCommonTools/main.qml"));
    //viewer.showExpanded();
    viewer.showFullScreen();
    return app.exec();
}
