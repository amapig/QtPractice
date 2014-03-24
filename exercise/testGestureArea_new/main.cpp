#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QQuickWindow>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickWindow::setDefaultAlphaBuffer(true);
    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/app/qtquick20/main.qml"));
    viewer.showExpanded();

    return app.exec();
}

