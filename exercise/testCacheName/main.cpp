#include <QtGui/QGuiApplication>
#include <QDebug>
#include <QCryptographicHash>
#include "qtquick2applicationviewer.h"

QByteArray cacheKey(const QString &id, const QSize &requestedSize)
{
    qDebug() << "id = " << id;
    QByteArray baId = id.toLatin1();

    for (int i = 0; i < baId.size(); i ++) {
        qDebug() << "array = " << baId[i];
    }
    // check if we have it in cache
    QCryptographicHash hash(QCryptographicHash::Sha1);

    hash.addData(baId.constData(), baId.length());
    qDebug() << "1111has.result() = " << hash.result();
    qDebug() << "2222has.result() = " << hash.result().toHex();
    return hash.result().toHex() + "nemo" +
           QString::number(requestedSize.width()).toLatin1() + "x" +
           QString::number(requestedSize.height()).toLatin1();;
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/testCacheName/main.qml"));
    viewer.showExpanded();

    QSize requestSize;
    requestSize.setHeight(200);
    requestSize.setWidth(200);
    qDebug() << "++++aaaaaaaa" << cacheKey("/home/mengcong/Pictures/1.jpg", requestSize);
    qDebug() << "++++bbbbbbbb" << cacheKey("/home/mengcong/Pictures/1.jpg", requestSize);

    return app.exec();
}
