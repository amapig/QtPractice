#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QQmlContext>

#include "../connection.h"
#include "editablesqlmodel.h"

//void initializeModel(QSqlQueryModel *model)
//{
//    model->setQuery("select * from person");
//    model->setHeaderData(0, Qt::Horizontal, QObject::tr("ID"));
//    model->setHeaderData(1, Qt::Horizontal, QObject::tr("First name"));
//    model->setHeaderData(2, Qt::Horizontal, QObject::tr("Last name"));
//}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    if (!createConnection())
        return 1;

    QtQuick2ApplicationViewer viewer;

    EditableSqlModel *editableModel = new EditableSqlModel;
    //initializeModel(editableModel);

//    editableModel->insertMetadata("/home/mengcong", 100,100,100);
//    editableModel->insertMetadata("/home/meng", 100,100,100);
//    editableModel->insertMetadata("/home/cong", 100,100,100);
//    editableModel->removeMetadata("/home/meng");
    editableModel->updateLastTime("/home/cong", 111);

    viewer.rootContext()->setContextProperty("mymodel", editableModel);

    viewer.setMainQmlFile(QStringLiteral("qml/testSqlQueryModel/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
