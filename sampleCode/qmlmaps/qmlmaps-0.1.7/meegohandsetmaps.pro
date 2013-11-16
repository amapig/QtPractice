CONFIG += mobility
CONFIG += qdeclarative-boostable 
MOBILITY += location
QT+= declarative
TEMPLATE = app
TARGET = meego-handset-maps
DESTDIR = bin

include(src/src.pri)

include(deployment.pri)
qtcAddDeployment()
