/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the QML Gesture Area plugin of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions
** contained in the Technology Preview License Agreement accompanying
** this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights.  These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
**
**
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "qdeclarativegesturehandler_p.h"

#include <QtCore/qdebug.h>
#include <QtCore/qstringlist.h>

#include <QtGui/qevent.h>

#ifndef QT_NO_GESTURES

QT_BEGIN_NAMESPACE

class QDeclarativeGestureHandlerPrivate
{
public:
    QDeclarativeGestureHandlerPrivate()
        : gestureType((Qt::GestureType)0), gesture(0) { }

    int gestureType;
    QDeclarativeScriptString when;
    QDeclarativeScriptString onStarted;
    QDeclarativeScriptString onUpdated;
    QDeclarativeScriptString onCanceled;
    QDeclarativeScriptString onFinished;
    QObject *gesture;
};

// remove me and search-n-replace GESTUREHANDLER_D to Q_D
// when put this plugin back to the Qt source tree
#define GESTUREHANDLER_D(x) x##Private *d = d_ptr

QDeclarativeGestureHandler::QDeclarativeGestureHandler(QObject *parent)
    : QObject(parent)
{
    d_ptr = new QDeclarativeGestureHandlerPrivate;
}

QDeclarativeGestureHandler::~QDeclarativeGestureHandler()
{
    delete d_ptr; d_ptr = 0;
}

bool QDeclarativeGestureHandler::isWhenKnown() const
{
    GESTUREHANDLER_D(const QDeclarativeGestureHandler);
    return !d->when.script().isEmpty();
}

QDeclarativeScriptString QDeclarativeGestureHandler::when() const
{
    GESTUREHANDLER_D(const QDeclarativeGestureHandler);
    return d->when;
}

void QDeclarativeGestureHandler::setWhen(const QDeclarativeScriptString &when)
{
    GESTUREHANDLER_D(QDeclarativeGestureHandler);
    d->when = when;
}

QDeclarativeScriptString QDeclarativeGestureHandler::onStarted() const
{
    GESTUREHANDLER_D(const QDeclarativeGestureHandler);
    return d->onStarted;
}

void QDeclarativeGestureHandler::setOnStarted(const QDeclarativeScriptString &script)
{
    GESTUREHANDLER_D(QDeclarativeGestureHandler);
    d->onStarted = script;
}

QDeclarativeScriptString QDeclarativeGestureHandler::onUpdated() const
{
    GESTUREHANDLER_D(const QDeclarativeGestureHandler);
    return d->onUpdated;
}

void QDeclarativeGestureHandler::setOnUpdated(const QDeclarativeScriptString &script)
{
    GESTUREHANDLER_D(QDeclarativeGestureHandler);
    d->onUpdated = script;
}

QDeclarativeScriptString QDeclarativeGestureHandler::onFinished() const
{
    GESTUREHANDLER_D(const QDeclarativeGestureHandler);
    return d->onFinished;
}

void QDeclarativeGestureHandler::setOnFinished(const QDeclarativeScriptString &script)
{
    GESTUREHANDLER_D(QDeclarativeGestureHandler);
    d->onFinished = script;
}

QDeclarativeScriptString QDeclarativeGestureHandler::onCanceled() const
{
    GESTUREHANDLER_D(const QDeclarativeGestureHandler);
    return d->onCanceled;
}

void QDeclarativeGestureHandler::setOnCanceled(const QDeclarativeScriptString &script)
{
    GESTUREHANDLER_D(QDeclarativeGestureHandler);
    d->onCanceled = script;
}

QObject *QDeclarativeGestureHandler::gesture() const
{
    return d_func()->gesture;
}

void QDeclarativeGestureHandler::setGesture(QObject *gesture)
{
    d_func()->gesture = gesture;
}

int QDeclarativeGestureHandler::gestureType() const
{
    return d_func()->gestureType;
}

void QDeclarativeGestureHandler::setGestureType(int gestureType)
{
    d_func()->gestureType = gestureType;
}


QT_END_NAMESPACE

#endif // QT_NO_GESTURES
