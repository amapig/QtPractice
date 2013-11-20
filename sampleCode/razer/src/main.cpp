#include "Razer.h"

#include <QtGui>
#include <QtDeclarative>

int main( int argc, char** argv ) {
    QApplication app( argc, argv );
    Razer window;
    window.setWindowTitle("Razer");
    window.setWindowFlags( Qt::FramelessWindowHint | Qt::WindowSystemMenuHint );
    window.setSource( QUrl::fromLocalFile(qApp->applicationDirPath() + "/ui/razer/Razer.qml") );
    window.show();
    return app.exec();
}
