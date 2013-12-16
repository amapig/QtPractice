//#include <QtGui/QGuiApplication>
#include <QApplication>
#include <QDesktopWidget>
#include <QRect>
#include "qtquick2applicationviewer.h"
#include <QQmlContext>
#include <QtDebug>

int main(int argc, char *argv[])
{
    //QGuiApplication app(argc, argv);
    QApplication a(argc, argv);
    QtQuick2ApplicationViewer viewer;

    QDesktopWidget* desktopWidget = a.desktop();
    // QRect deskRect = desktopWidget->availableGeometry();
    QRect screenRect = desktopWidget->screenGeometry();

    int g_nActScreenX = screenRect.width();
    int g_nActScreenY = screenRect.height();

    viewer.rootContext()->setContextProperty("currentWidth", g_nActScreenX);
    viewer.rootContext()->setContextProperty("currentHeight", g_nActScreenY);

    qDebug() << "width = " << g_nActScreenX << "height = " << g_nActScreenY;

    viewer.setMainQmlFile(QStringLiteral("qml/testResolution/main.qml"));
    viewer.showExpanded();

    return a.exec();
}
