#ifndef CPLUSPLUS2QML_H
#define CPLUSPLUS2QML_H

class Message : public QObject
{
public:
    Q_OBJECT
    Q_PROPERTY(QString author READ author WRITE setAuthor NOTIFY authorChanged)
    Q_PROPERTY(QDateTime creationDate READ creationDate WRITE setCreationDate NOTIFY creationDateChanged)
};

#endif // CPLUSPLUS2QML_H

