# Copyright (c) 2012 Nokia Corporation.

DEFINES += CAMERA_KEY_HANDLING

INCLUDEPATH += $$PWD

HEADERS += $$PWD/camerakeylistener.h

SOURCES += $$PWD/camerakeylistener.cpp

# For the camera key handling
LIBS += -lcone -lws32

# Camera key capturing requires SwEvent
TARGET.CAPABILITY += SwEvent
