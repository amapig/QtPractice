#ifndef STOPWATCH_H
#define STOPWATCH_H

#include <QObject>

class Stopwatch : public QObject
{
    Q_OBJECT
public:
    Stopwatch();

    Q_INVOKABLE bool isRunning();

//QML中可以调用QObject及其派生类对象中的public slots的方法或标记为Q_INVOKABLE的方法。
public slots:
    void start();
    void stop();

private:
    bool m_running;
};

#endif // STOPWATCH_H
