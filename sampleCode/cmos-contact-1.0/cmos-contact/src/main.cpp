/*
 * Copyright (C) 2011 Robin Burchell <robin+mer@viroteck.net>
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * "Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *   * Neither the name of Nemo Mobile nor the names of its contributors
 *     may be used to endorse or promote products derived from this
 *     software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 */

#include <QDesktopServices>
#include <QGuiApplication>
#include <QApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#include <QDebug>
#include <QDir>
#ifdef HAS_BOOSTER
#include <mdeclarativecache5/MDeclarativeCache>
#endif
#include "declarativeview.h"
#ifdef HAS_BOOSTER
Q_DECL_EXPORT
#endif

#include <stdio.h>
int main(int argc, char **argv)
{
    QQuickView *pParentView;//
#ifdef HAS_BOOSTER
    QGuiApplication *application;
    application = MDeclarativeCache::qApplication(argc, argv);
    pParentView = MDeclarativeCache::qQuickView();
#else
    QGuiApplication *application;
    qWarning() << Q_FUNC_INFO << "Warning! Running without booster. This may be a bit slower.";
    QApplication stackApp(argc, argv);
    QQuickView stackView;
    application = &stackApp;
    pParentView = &stackView;
#endif

    bool isFullscreen = false;
    QStringList arguments = application->arguments();
    for (int i = 0; i < arguments.count(); ++i) {
        QString parameter = arguments.at(i);
        if (parameter == "-fullscreen") {
            isFullscreen = true;
        } else if (parameter == "-help") {
            qDebug() << "Contacts application";
            qDebug() << "-fullscreen   - show QML fullscreen";
            exit(0);
        }
    }

    DeclarativeView view(pParentView);

    
    bool bShowFullScreen = true;

    int i;
    for (i=0;i<application->arguments().size();i++)
    {
        if (strcmp(argv[i], "-fromDBus") == 0)        
        {
            bShowFullScreen = false;
        }
    }

    if(!application->arguments().contains("-prestart", Qt::CaseInsensitive) &&
       !application->arguments().contains("-fromDBus")  && bShowFullScreen == true)
    {
        view.show();
    }

    QObject::connect(pParentView->engine(), SIGNAL(quit()), application, SLOT(quit()));

    return application->exec();
}

