#include "mainwindow.h"
#include <QApplication>
#include <QFileSystemModel>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    QFileSystemModel *model = new QFileSystemModel;
    QModelIndex parentIndex = model->index(QDir::currentPath());
    int numRows = model->rowCount(parentIndex);

    return a.exec();
}
