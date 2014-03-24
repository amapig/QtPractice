#-------------------------------------------------
#
# Project created by QtCreator 2014-03-24T16:32:36
#
#-------------------------------------------------

QT       += core

QT       -= gui

TARGET = testGlib
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app

INCLUDEPATH += /usr/include/glib-2.0/ \
               /usr/local/lib/glib-2.0/include/

LIBS += /usr/local/lib/libglib-2.0.so

SOURCES += main.cpp
