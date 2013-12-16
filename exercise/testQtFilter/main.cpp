#include <QApplication>
#include "colornamesdialog.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    ColorNamesDialog w;
    w.show();
    w.setWindowTitle("QSortFilterProxyModel Demo");
    return a.exec();
}
