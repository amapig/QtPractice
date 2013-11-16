#include "mymode.h"

MyModel::MyModel(QObject *parent) :QAbstractTableModel(parent)
{
    // selectedCell = 0;
    timer = new QTimer(this); // Need to delete
    timer->setInterval(1000);
    connect(timer, SIGNAL(timeout()) , this, SLOT(timerHit()));
    timer->start();
}

MyModel::~MyModel()
{
    delete timer;
}

int MyModel::rowCount(const QModelIndex &parent) const
{
    return ROWS;
}

int MyModel::columnCount(const QModelIndex &parent) const
{
    return COLS;
}

void MyModel::timerHit()
{
    //we identify the top left cell
    QModelIndex topLeft = createIndex(1,2);
    //emit a signal to make the view reread identified data
    emit dataChanged(topLeft, topLeft);
}

QVariant MyModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    int column = index.column();

    qDebug() << QString("row %1, col%2, role %3")
                .arg(row).arg(column).arg(role);

    if (role == Qt::DisplayRole)
    {
        return m_gridData[index.row()][index.column()];
    }

/*
    switch(role)
    {
    case Qt::DisplayRole:
        if(0 == row && 0 == column) return "hello 0:0";
        if(0 == row && 1 == column) return "hi 0:1";
        if(1 == row && 0 == column) return "hi 1:0";

        if(1 == row && 2 == column) {
            return QTime::currentTime().toString();
        }

        break;
    case Qt::FontRole:
        if((0 == row && 0 == column) ||
                1 == row && 0 == column)
        {
            QFont font;
            font.setBold(true);
            font.setOverline(true);
            return font;
        }
    }
*/
    return QVariant();
}

QVariant MyModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal) {
            switch (section)
            {
            case 0:
                return QString("first");
            case 1:
                return QString("second");
            case 2:
                return QString("third");
            }
        }
        if (orientation == Qt::Vertical) {
            switch (section)
            {
            case 0:
                return QString("num:1");
            case 1:
                return QString("num:2");
            case 2:
                return QString("num:3");
            }
        }
    }
    return QVariant();
}

bool MyModel::setData(const QModelIndex & index, const QVariant & value, int role)
{
    if (role == Qt::EditRole)
    {
        //save value from editor to member m_gridData
        m_gridData[index.row()][index.column()] = value.toString();
        //for presentation purposes only: build and emit a joined string
        QString result;
        for(int row= 0; row < ROWS; row++)
        {
            for(int col= 0; col < COLS; col++)
            {
                result += m_gridData[row][col] + " ";
            }
        }
        emit editCompleted( result );
    }
    return true;
}

Qt::ItemFlags MyModel::flags(const QModelIndex &index) const
{
    return Qt::ItemIsEditable | QAbstractTableModel::flags(index);
}
