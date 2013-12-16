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

#ifndef QDECLARATIVEGESTUREHANDLER_H
#define QDECLARATIVEGESTUREHANDLER_H

#include <QtDeclarative/qdeclarative.h>
#include <QtDeclarative/qdeclarativescriptstring.h>
#include <QtCore/qobject.h>
#include <QtCore/qstringlist.h>
#include <QtGui/qgesture.h>

#ifndef QT_NO_GESTURES

QT_BEGIN_HEADER

QT_BEGIN_NAMESPACE

QT_MODULE(Declarative)

class QGesture;
class QDeclarativeBinding;
class QDeclarativeGestureHandlerPrivate;
class QDeclarativeGestureHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int gestureType READ gestureType WRITE setGestureType)
    Q_PROPERTY(QObject *parent READ parent DESIGNABLE false FINAL)
    Q_PROPERTY(QDeclarativeScriptString when READ when WRITE setWhen)
    Q_PROPERTY(QDeclarativeScriptString onStarted READ onStarted WRITE setOnStarted)
    Q_PROPERTY(QDeclarativeScriptString onUpdated READ onUpdated WRITE setOnUpdated)
    Q_PROPERTY(QDeclarativeScriptString onCanceled READ onCanceled WRITE setOnCanceled)
    Q_PROPERTY(QDeclarativeScriptString onFinished READ onFinished WRITE setOnFinished)
    Q_PROPERTY(QObject *gesture READ gesture WRITE setGesture NOTIFY gestureChanged)

public:
    bool isWhenKnown() const;
    QDeclarativeScriptString when() const;
    void setWhen(const QDeclarativeScriptString &script);

    QDeclarativeScriptString onStarted() const;
    void setOnStarted(const QDeclarativeScriptString &script);

    QDeclarativeScriptString onUpdated() const;
    void setOnUpdated(const QDeclarativeScriptString &script);

    QDeclarativeScriptString onCanceled() const;
    void setOnCanceled(const QDeclarativeScriptString &script);

    QDeclarativeScriptString onFinished() const;
    void setOnFinished(const QDeclarativeScriptString &script);

    QObject *gesture() const;
    void setGesture(QObject *gesture);

    int gestureType() const;

Q_SIGNALS:
    void gestureChanged();

protected:
    QDeclarativeGestureHandler(QObject *parent = 0);
    ~QDeclarativeGestureHandler();

    void setGestureType(int type);

private:
    QDeclarativeGestureHandlerPrivate *d_ptr;

    friend class QDeclarativeGestureArea;
    Q_DISABLE_COPY(QDeclarativeGestureHandler)
    Q_DECLARE_PRIVATE(QDeclarativeGestureHandler)
};

class QDeclarativePanGestureHandler : public QDeclarativeGestureHandler
{
    Q_OBJECT
public:
    QDeclarativePanGestureHandler(QObject *parent = 0)
        : QDeclarativeGestureHandler(parent)
    {
        setGestureType(Qt::PanGesture);
    }

private:
    Q_DISABLE_COPY(QDeclarativePanGestureHandler)
};

class QDeclarativeDefaultGestureHandler : public QDeclarativeGestureHandler
{
    Q_OBJECT
public:
    QDeclarativeDefaultGestureHandler(QObject *parent = 0)
        : QDeclarativeGestureHandler(parent)
    {
    }

private:
    Q_DISABLE_COPY(QDeclarativeDefaultGestureHandler)
};

class QDeclarativePinchGestureHandler : public QDeclarativeGestureHandler
{
    Q_OBJECT
public:
    QDeclarativePinchGestureHandler(QObject *parent = 0)
        : QDeclarativeGestureHandler(parent)
    {
        setGestureType(Qt::PinchGesture);
    }

private:
    Q_DISABLE_COPY(QDeclarativePinchGestureHandler)
};

class QDeclarativeTapGestureHandler : public QDeclarativeGestureHandler
{
    Q_OBJECT
public:
    QDeclarativeTapGestureHandler(QObject *parent = 0)
        : QDeclarativeGestureHandler(parent)
    {
        setGestureType(Qt::TapGesture);
    }

private:
    Q_DISABLE_COPY(QDeclarativeTapGestureHandler)
};

class QDeclarativeTapAndHoldGestureHandler : public QDeclarativeGestureHandler
{
    Q_OBJECT
public:
    QDeclarativeTapAndHoldGestureHandler(QObject *parent = 0)
        : QDeclarativeGestureHandler(parent)
    {
        setGestureType(Qt::TapAndHoldGesture);
    }

private:
    Q_DISABLE_COPY(QDeclarativeTapAndHoldGestureHandler)
};

class QDeclarativeSwipeGestureHandler : public QDeclarativeGestureHandler
{
    Q_OBJECT
public:
    QDeclarativeSwipeGestureHandler(QObject *parent = 0)
        : QDeclarativeGestureHandler(parent)
    {
        setGestureType(Qt::SwipeGesture);
    }

private:
    Q_DISABLE_COPY(QDeclarativeSwipeGestureHandler)
};

QT_END_NAMESPACE

QML_DECLARE_TYPE(QDeclarativeGestureHandler)
QML_DECLARE_TYPE(QDeclarativeDefaultGestureHandler)
QML_DECLARE_TYPE(QDeclarativePanGestureHandler)
QML_DECLARE_TYPE(QDeclarativePinchGestureHandler)
QML_DECLARE_TYPE(QDeclarativeTapGestureHandler)
QML_DECLARE_TYPE(QDeclarativeTapAndHoldGestureHandler)
QML_DECLARE_TYPE(QDeclarativeSwipeGestureHandler)

QT_END_HEADER

#endif // QT_NO_GESTURES

#endif
