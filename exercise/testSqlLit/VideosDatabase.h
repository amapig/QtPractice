#ifndef VIDEOSDATABASE_H
#define VIDEOSDATABASE_H

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QStringList>

class VideosDatabase : public QObject
{
    Q_OBJECT
public:
    explicit VideosDatabase(QObject *parent = 0);
    ~VideosDatabase();

public slots:
    void clear();
    bool remove(QString filename);

    void insertPosition(QString filename,
                        int duration,
                        int position,
                        int lasttime);

    void insertDuration(QString filename, int duration);
    void insertLastTime(QString filename, int lasttime);
    int getPosition(QString filename);
    int getDuration(QString filename);
    int getLastTime(QString filename);

private:
    void init();

    QSqlDatabase myConnection;

};

#endif // VIDEOSDATABASE_H
