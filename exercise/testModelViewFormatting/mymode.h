#ifndef MYMODEL_H
#define MYMODEL_H
#include <QAbstractTableModel>
#include <QDebug>
#include <QFont>
#include <QTime>
#include <QTimer>
#include <QHeaderView>
#include <QTreeView>

const int ROWS= 3;
const int COLS= 4;

class MyModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    MyModel(QObject *parent);
    ~MyModel();
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;

    bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);
    Qt::ItemFlags flags(const QModelIndex & index) const ;

private slots:
    void timerHit();   // slot function must be defined to slots.

private:
    QTimer *timer;
    QString m_gridData[ROWS][COLS];  //holds text entered into QTableView
signals:
    void editCompleted(const QString &);
};

#endif
