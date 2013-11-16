#ifndef QEXAMPLEQMLPLUGIN_H
#define QEXAMPLEQMLPLUGIN_H

#include <QQmlExtensionPlugin>
#include <QtQml>
#include "TimeModule.h"

class QExampleQmlPlugin : public QQmlExtensionPlugin {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // QEXAMPLEQMLPLUGIN_H
