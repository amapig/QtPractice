#include "datadirectory.h"
#include <QDir>
#include <QStandardPaths>
#include <QDebug>

QString DataDirectory::Path;
QString DataDirectory::Covers;

void DataDirectory::initialize()
{
    QDir dataDir(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
    qDebug() << "Using data location:" << dataDir.path();
    if (! dataDir.exists("mediaboxcore"))
    {
        bool ok = dataDir.mkpath("mediaboxcore");
        if (! ok)
            qCritical() << "could not create data directory";
    }

    dataDir.cd("mediaboxcore");
    if (! dataDir.exists("covers"))
    {
        bool ok = dataDir.mkdir("covers");
        if (! ok)
            qCritical() << "could not create covers directory";
    }
    dataDir.cd("covers");
    Covers = dataDir.path();

    dataDir.cdUp();
    Path = dataDir.path();
}
