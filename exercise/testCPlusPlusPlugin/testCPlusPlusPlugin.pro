# Add more folders to ship with the application, here
#folder_01.source = qml/testCPlusPlusPlugin
# folder_01.target = qml
# DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
# SOURCES += main.cpp

# Installation path
# target.path =
TARGET = qmlqtimeexapleplugin

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

DESTDIR = imports/TimeExample
TEMPLATE = lib
CONFIG += qt plugin
QT += qml

HEADERS += \
    TimeModule.h \
    QExampleQmlPlugin.h

OTHER_FILES += \
    qmldir

SOURCES += \
    TimeModule.cpp \
    QExampleQmlPlugin.cpp
