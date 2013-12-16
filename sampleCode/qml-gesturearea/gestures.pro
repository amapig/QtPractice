TARGETPATH = Qt/labs/gestures

TEMPLATE = lib
CONFIG += qt plugin
TARGET = $$qtLibraryTarget(qmlgestureareaplugin)
QT += declarative

SOURCES += qdeclarativegesturearea.cpp \
           qdeclarativegesturehandler.cpp \
           qdeclarativegesturerecognizers.cpp \
           plugin.cpp
HEADERS += qdeclarativegesturearea_p.h \
           gestureareaplugin_p.h \
           qdeclarativegesturehandler_p.h \
           qdeclarativegesturerecognizers_p.h

QTDIR_build:DESTDIR = $$QT_BUILD_TREE/imports/$$TARGETPATH
else:DESTDIR = imports/$$TARGETPATH
target.path = $$[QT_INSTALL_IMPORTS]/$$TARGETPATH

qmldir.files += $$PWD/qmldir
qmldir.path +=  $$[QT_INSTALL_IMPORTS]/$$TARGETPATH

symbian:{
    TARGET.UID3 = 0x2002131F
    TARGET.EPOCALLOWDLLDATA = 1
    include($$QT_SOURCE_TREE/demos/symbianpkgrules.pri)

    importFiles.sources = $$DESTDIR/qmlgestureareaplugin$${QT_LIBINFIX}.dll qmldir
    importFiles.path = $$QT_IMPORTS_BASE_DIR/$$TARGETPATH

    DEPLOYMENT = importFiles
}

QMAKE_POST_LINK=$(COPY_FILE) $$PWD/qmldir $$DESTDIR

INSTALLS += target qmldir
