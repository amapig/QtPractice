#ifndef MAINWIN_H
#define MAINWIN_H
#include <QtWidgets/QtWidgets>

class MainWin : public QWidget
{
    Q_OBJECT
public:
    MainWin(QWidget *parent = 0);

private slots:
    void doClicked(const QString & btnname);//处理最终信号的槽

private:
    QSignalMapper *signalMapper;
};

#endif // MAINWIN_H
