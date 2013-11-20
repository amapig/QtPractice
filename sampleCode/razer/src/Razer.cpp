#include "Razer.h"

#include <QtCore/QDebug>
#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeEngine>

Razer::Razer( QWidget *parent ): QDeclarativeView( parent ) {
    _allowMove = false;
    connect(engine(), SIGNAL(quit()), qApp, SLOT(quit()));
}

Razer::~Razer() {

}

void Razer::mousePressEvent( QMouseEvent *evt ) {
    QDeclarativeView::mousePressEvent( evt );
    if ( evt->button() == Qt::LeftButton && evt->y() <= 16 /*FIX THIS FOR CONSTAN*/ ) {
        _dragPos = evt->globalPos() - frameGeometry().topLeft();
        _allowMove = true;
        evt->accept();
    }
}

void Razer::mouseMoveEvent( QMouseEvent *evt ) {
    QDeclarativeView::mouseMoveEvent( evt );
    if ( _allowMove ) {
        move(evt->globalPos() - _dragPos);
        evt->accept();
    }
}

void Razer::mouseReleaseEvent( QMouseEvent *evt ) {
    QDeclarativeView::mouseReleaseEvent( evt );
    _allowMove = false;
}

// PRIVATE SECTION
Razer::Razer( const Razer& other ) {

}

Razer& Razer::operator=( const Razer & other ) {
    return *this;
}
