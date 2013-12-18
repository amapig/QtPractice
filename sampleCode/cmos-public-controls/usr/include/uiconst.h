#ifndef UICONST_H
#define UICONST_H

#include <QObject>
#include <QSettings>
class UIConst : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(UIConst)


public:
    UIConst(QObject *parent = 0);
    ~UIConst();    

public slots:
    QVariant getValue(QString name);

};

#endif // UICONST_H
