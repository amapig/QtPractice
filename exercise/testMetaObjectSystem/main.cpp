#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

#include "MyObject.h"
#include "mainwin.h"

int main(int argc, char *argv[])
{
//==================1 begin=====================
//    QGuiApplication app(argc, argv);

//    QtQuick2ApplicationViewer viewer;
//    viewer.setMainQmlFile(QStringLiteral("qml/testMetaObjectSystem/main.qml"));
//    viewer.showExpanded();

//    QObject *obj = new MyObject;
//    MyObject *widget = qobject_cast<MyObject *>(obj);
//==================1 end=====================

    //-----------2 begin----------

    printf("++++++++2 begin++++++++");
    QGuiApplication app(argc, argv);
    MainWin *myMainWin = new MainWin();
    printf("++++++++2 end++++++++");

    return app.exec();
}
