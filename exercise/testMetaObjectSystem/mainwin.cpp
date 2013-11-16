#include "mainwin.h"

MainWin::MainWin(QWidget *parent) : QWidget(parent)
{
    QString buttontext = "btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,btn10";//10个button
    QStringList texts = buttontext.split(",");
    signalMapper = new QSignalMapper(this);
    QGridLayout *gridLayout = new QGridLayout;
    for (int i = 0; i < texts.size(); ++i)
    {
        QPushButton *button = new QPushButton(texts[i]);
        connect(button, SIGNAL(clicked()), signalMapper, SLOT(map ()));//原始信号传递给signalmapper
        signalMapper->setMapping (button, texts[i]);
        //设置signalmapper的转发规则, 转发为参数为QString类型的信号， 并把texts[i]的内容作为实参传递.
        gridLayout->addWidget(button, i / 3, i % 3);
    }

    connect(signalMapper, SIGNAL(mapped (const QString &)), this, SLOT(doClicked(const QString &)));//将转发的信号连接到最终的槽函数
    setLayout(gridLayout);
}

void MainWin::doClicked(const QString& btnname)
{
    QMessageBox::information(this, "Clicked", btnname + " is clicked!");//显示被按下的btn名称。
}
