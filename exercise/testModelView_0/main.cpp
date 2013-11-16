#include <QApplication>
#include <QSplitter>
#include <QDirModel>
#include <QTreeView>
#include <QListView>

#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QSplitter *splitter = new QSplitter;
    QDirModel *model = new QDirModel;
    //从缺省目录创建数据
    QTreeView *tree = new QTreeView(splitter);
    tree->setModel(model);
    tree->setRootIndex(model->index(QDir::currentPath()));
    QListView *list = new QListView(splitter);
    list->setModel(model);
    list->setRootIndex(model->index(QDir::currentPath()));
    //配置一个view去显示model中的数据，只需要简单地调用setModel(),并把目录model作为参数传递
    //setRootIndex()告诉views显示哪个目录的信息，这需要提供一个model index,然后用这个
    //model index去model中去获取数据
    //index()这个函数是QDirModel特有的，通过把一个目录做为参数，得到了需要的model index
    //其他的代码只是窗口show出来,进入程序的事件循环就好了
    splitter->setWindowTitle("Two views onto the same directory model");
    splitter->show();
    return app.exec();
}
