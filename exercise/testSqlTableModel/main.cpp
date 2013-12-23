#include <QApplication>
#include "qtquick2applicationviewer.h"

#include <QtWidgets>
#include <QtSql>

#include "connection.h"

bool insertPosition(QSqlTableModel *model)
{
    model->insertRow(5);
}

void initializeModel(QSqlTableModel *model)
{
    model->setTable("items");
    model->setEditStrategy(QSqlTableModel::OnManualSubmit);
    model->select();

    insertPosition(model);
    model->submitAll();
}

QTableView *createView(QSqlTableModel *model, const QString &title = "")
{
    QTableView *view = new QTableView;
    view->setModel(model);
    view->setWindowTitle(title);
    return view;
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //--------Begin copy--------
    if (!createConnection())
        return 1;

    QSqlTableModel model;

    initializeModel(&model);

    //QTableView *view1 = createView(&model, QObject::tr("Table Model (View 1)"));
    //QTableView *view2 = createView(&model, QObject::tr("Table Model (View 2)"));

    //view1->show();
    //view2->move(view1->x() + view1->width() + 20, view1->y());
    //view2->show();
    //--------End copy--------

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/testSqlTableModel/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
