#include "QExampleQmlPlugin.h"

void QExampleQmlPlugin::registerTypes(const char *uri) {
    Q_ASSERT(uri == QLatin1String("TimeExample"));
    qmlRegisterType<TimeModel>(uri, 1, 0, "Time1");
}
