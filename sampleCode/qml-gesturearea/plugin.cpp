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

#include <QtDeclarative/qdeclarative.h>

#include "gestureareaplugin_p.h"
#include "qdeclarativegesturearea_p.h"
#include "qdeclarativegesturerecognizers_p.h"

QT_BEGIN_NAMESPACE

void GestureAreaQmlPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("Qt.labs.gestures"));
#ifndef QT_NO_GESTURES
    qmlRegisterType<QDeclarativeGestureArea>(uri, 2, 0, "GestureArea");

    qmlRegisterUncreatableType<QDeclarativeGestureHandler>(uri, 2, 0, "GestureHandler", QLatin1String("Do not create objects of this type."));

    qmlRegisterUncreatableType<QGesture>(uri, 2, 0, "Gesture", QLatin1String("Do not create objects of this type."));
    qmlRegisterUncreatableType<QPanGesture>(uri, 2, 0, "PanGesture", QLatin1String("Do not create objects of this type."));
    qmlRegisterUncreatableType<QTapGesture>(uri, 2, 0, "TapGesture", QLatin1String("Do not create objects of this type."));
    qmlRegisterUncreatableType<QTapAndHoldGesture>(uri, 2, 0, "TapAndHoldGesture", QLatin1String("Do not create objects of this type."));
    qmlRegisterUncreatableType<QPinchGesture>(uri, 2, 0, "PinchGesture", QLatin1String("Do not create objects of this type."));
    qmlRegisterUncreatableType<QSwipeGesture>(uri, 2, 0, "SwipeGesture", QLatin1String("Do not create objects of this type."));

    qmlRegisterType<QDeclarativeDefaultGestureHandler>(uri, 2, 0, "Default");
    qmlRegisterType<QDeclarativePanGestureHandler>(uri, 2, 0, "Pan");
    qmlRegisterType<QDeclarativeTapGestureHandler>(uri, 2, 0, "Tap");
    qmlRegisterType<QDeclarativeTapAndHoldGestureHandler>(uri, 2, 0, "TapAndHold");
    qmlRegisterType<QDeclarativePinchGestureHandler>(uri, 2, 0, "Pinch");
    qmlRegisterType<QDeclarativeSwipeGestureHandler>(uri, 2, 0, "Swipe");

    QGestureRecognizer::unregisterRecognizer(Qt::TapGesture);
    QGestureRecognizer::unregisterRecognizer(Qt::TapAndHoldGesture);
    QGestureRecognizer::unregisterRecognizer(Qt::PanGesture);
    QGestureRecognizer::unregisterRecognizer(Qt::PinchGesture);
    QGestureRecognizer::unregisterRecognizer(Qt::SwipeGesture);

    QGestureRecognizer::registerRecognizer(new QTapGestureRecognizer());
    QGestureRecognizer::registerRecognizer(new QTapAndHoldGestureRecognizer());
    QGestureRecognizer::registerRecognizer(new QPanGestureRecognizer());
    QGestureRecognizer::registerRecognizer(new QPinchGestureRecognizer());
    QGestureRecognizer::registerRecognizer(new QSwipeGestureRecognizer());
#endif
}

GestureAreaQmlPlugin *GestureAreaQmlPlugin::self = 0;

QT_END_NAMESPACE


Q_EXPORT_PLUGIN2(qmlgestureareaplugin, QT_PREPEND_NAMESPACE(GestureAreaQmlPlugin));
