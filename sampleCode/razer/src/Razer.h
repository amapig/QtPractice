#ifndef RAZER_H
#define RAZER_H

#include <QtGui/QMouseEvent>
#include <QtDeclarative/QDeclarativeView>

class Razer: public QDeclarativeView {

public:
    Razer( QWidget * = 0 );
    virtual ~Razer();
    virtual void mousePressEvent( QMouseEvent * );
    virtual void mouseMoveEvent( QMouseEvent * );
    virtual void mouseReleaseEvent( QMouseEvent * );

private:
    Razer( const Razer& other );
    virtual Razer& operator=( const Razer& other );

private:
    bool _allowMove;
    QPoint _dragPos;
};

#endif // RAZER_H
