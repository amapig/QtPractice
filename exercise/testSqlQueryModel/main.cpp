#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QQmlContext>

#include "ArtistsSqlModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    ArtistsSqlModel *artistsSqlModel = new ArtistsSqlModel( qApp);
    viewer.rootContext()->setContextProperty("artistsModel", artistsSqlModel);
    //    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    viewer.setMainQmlFile(QStringLiteral("qml/testSqlQueryModel/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
