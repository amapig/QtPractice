#include <QApplication>
#include <QtWidgets/QTableView>

#include "mymode.h"
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QTableView tableView;
    MyModel myModel(0);
    tableView.setModel(&myModel);

    //hide header
//    tableView.verticalHeader()->hide();
//    tableView.horizontalHeader()->hide();

    tableView.show();

    QTreeView treeView;
    treeView.setModel(&myModel);
    treeView.show();

    return a.exec();
}
