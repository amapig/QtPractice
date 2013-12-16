/****************************************************************************
**
** Copyright (C) 2013 Jolla Ltd. <robin.burchell@jollamobile.com>
** Copyright (C) 2011-2012 Tom Swindell <t.swindell@rubyx.co.uk>
** All rights reserved.
**
** This file is part of the Voice Call UI project.
**
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * The names of its contributors may NOT be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
****************************************************************************/

#include "declarativeview.h"
#include "dbusadaptor.h"

#include <QQmlEngine>
#include <QQmlContext>
#include <QDBusConnection>
#include <QCoreApplication>
#include <QDebug>
#include <QStandardPaths>

DeclarativeView::DeclarativeView(QQuickView *parent)
    : QObject(parent)
{
	 pParentView = parent;
    new DBusAdaptor(this);
    QDBusConnection::sessionBus().registerService("org.nemomobile.qmlcontacts");
    if (!QDBusConnection::sessionBus().registerObject("/", this))
        qWarning() << Q_FUNC_INFO << "Cannot register DBus object!";

  //  pParentView->setResizeMode(QQuickView::SizeRootObjectToView);
   pParentView->rootContext()->setContextProperty("systemAvatarDirectory", QStandardPaths::writableLocation(QStandardPaths::PicturesLocation));
   pParentView->rootContext()->setContextProperty("DocumentsLocation", QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));

    //pParentView->setSource(QUrl("/media/sf_chenfu/code/sources/qmlcontacts-0.4.2.skytree3/src/qml/main.qml"));
    pParentView->setSource(QUrl("qrc:/qml/main.qml"));
}

DeclarativeView::~DeclarativeView()
{
}

void DeclarativeView::show()
{
    pParentView->requestActivate();
    pParentView->raise();
    static bool bDoneAlready = false;
    if (bDoneAlready == false)
    {
        pParentView->showFullScreen();
        bDoneAlready = true;
    }
}

void DeclarativeView::startAddContact(QString strPhoneNumber)
{
    QObject *object = (QObject *)pParentView->rootObject();
    QMetaObject::invokeMethod(object, "startAddContact", Q_ARG(QVariant, strPhoneNumber));
    show();
}
