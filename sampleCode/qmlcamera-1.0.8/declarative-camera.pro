TEMPLATE=app

CONFIG += mobility

# If CUSTOM_RESOURCES is set implement resource policy handling
# in meego-handset-camera. Otherwise let qt-mobility handle
# resources.
count(CUSTOM_RESOURCES, 1) {
    CONFIG += link_pkgconfig
    PKGCONFIG += libresourceqt1
    DEFINES += CUSTOM_RESOURCES
}


DEFINES+=Q_WS_MEEGO

QT += core declarative network opengl

MOBILITY = multimedia

HEADERS += \
    qmlcamerasettings.h \
    meegocamera.h \
    qdeclarativecamera_p.h \
    qdeclarativecamerapreviewprovider_p.h

SOURCES += main.cpp \
    qmlcamerasettings.cpp \
    meegocamera.cpp \
    qdeclarativecamera.cpp \
    qdeclarativecamerapreviewprovider.cpp

TARGET = meego-handset-camera
target.path=/usr/bin

RESOURCES += declarative-camera.qrc

app_icon.files = meegocamera.desktop
app_icon.path = /usr/share/applications

# XDG Autostart
# autostart disabled at the moment
#autostart_entry.files = meegocamera_background.desktop
#autostart_entry.path = /etc/xdg/autostart

config_file.files = meego-handset-camera.conf
config_file.path = /etc/xdg/Nokia

#INSTALLS += autostart_entry target app_icon config_file
INSTALLS += target app_icon config_file

OTHER_FILES += \
    TopPane.qml \
    BottomPane.qml \
    QuickSettingsPane.qml \
    CameraPropertyModel.qml
