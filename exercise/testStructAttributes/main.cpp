#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include "qtquick2applicationviewer.h"
#include "main.h"


/*
 * can not run now.
 * Because the vtable.
 * The rootcause is the qmake compiler can not compile the Q_OBJECT.
 *
 * Need to study later.
 */

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer view;
    view.rootContext()->setContextProperty("palette", new CustomPalette);

    view.setSource(QUrl::fromLocalFile("qml/testStructAttributes/main.qml"));
    view.show();

    return app.exec();
}
