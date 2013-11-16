#ifndef TIMEMODULE_H
#define TIMEMODULE_H
#include <QObject>

class TimeModel : public QObject {
    Q_OBJECT
    Q_PROPERTY(int hour READ hour WRITE writeHour NOTIFY timeChanged)
    Q_PROPERTY(int minute READ minute NOTIFY timeChanged)
public slots:
    int hour();
    int minute();
    Q_INVOKABLE void writeHour(int hour);
signals:
    void timeChanged();
private:
    int mHour;
    int mMinute;
};
#endif // TIMEMODULE_H
