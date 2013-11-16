#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    // Below two sentences must place before L15 and L16
    // Because we should set property firstly, and then
    // the qml file can get the "backgroundColor" property.
    QQmlContext *context = viewer.rootContext();
    context->setContextProperty("backgroundColor", QColor(Qt::yellow));

    // Seems same with below two sentences now.
    viewer.setSource(QUrl::fromLocalFile("qml/testCPlusPlusCallQml/main.qml"));
    //viewer.setMainQmlFile(QStringLiteral("qml/testCPlusPlusCallQml/main.qml"));

    viewer.showExpanded();

    return app.exec();
}
