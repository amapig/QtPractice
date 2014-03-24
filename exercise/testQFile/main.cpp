#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    QFile file("/home/skytree/1.txt");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qDebug() << "error here" << endl;
        return 0;
    }

    QTextStream out(&file);
    out << "The magic number is: " << 49 << "\n";

    viewer.setMainQmlFile(QStringLiteral("qml/testQFile/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
