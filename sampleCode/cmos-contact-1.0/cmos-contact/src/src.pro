VERSION = 0.3.9
PROJECT_NAME = qmlcontacts
TEMPLATE = app
CONFIG += ordered mobility hide_symbols
MOBILITY += contacts
QT += quick dbus qml
QT += widgets
TARGET = $$PROJECT_NAME
CONFIG -= app_bundle # OS X

CONFIG += link_pkgconfig

packagesExist(qdeclarative5-boostable) {
    message("Building with qdeclarative-boostable support")
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qdeclarative5-boostable
} else {
    warning("qdeclarative-boostable not available; startup times will be slower")
}

SOURCES += main.cpp \
           declarativeview.cpp \
           dbusadaptor.cpp
           
HEADERS += declarativeview.h \
           dbusadaptor.h          
           
RESOURCES += res.qrc

QML_FILES = qml/*.qml
JS_FILES = *qml/.js

OTHER_FILES += $${QML_FILES} $${JS_FILES} \
    qml/MySheet.qml \
    qml/MyTextFieldStyle.qml \
    qml/MyTextField.qml \
    qml/MyButton.qml \
    qml/MySelectionDialog.qml \
    qml/MyCommonDialog.qml \
    qml/MyDialog.qml \
    qml/MyPopup.qml \
    qml/MyFader.qml \
    qml/MyContactListWidget.qml \
    qml/MyContactListDelegate.qml \
    qml/MySectionScroller.qml \
    qml/MySectionScrollerLabel.qml \
    qml/FavoritesListPage.qml \
    qml/MyFvaoritesContactListDelegate.qml

target.path = $$INSTALL_ROOT/usr/bin/
INSTALLS += target

desktop.files = $${PROJECT_NAME}.desktop
desktop.path = $$INSTALL_ROOT/usr/share/applications
INSTALLS += desktop

# qml API we provide
qml_api.files = qml/api/*
qml_api.path = /usr/lib/qt5/qml/org/nemomobile/$$PROJECT_NAME
INSTALLS += qml_api

TRANSLATIONS += *.qml
dist.commands += rm -fR $${PROJECT_NAME}-$${VERSION} &&
dist.commands += git clone . $${PROJECT_NAME}-$${VERSION} &&
dist.commands += rm -fR $${PROJECT_NAME}-$${VERSION}/.git &&
dist.commands += rm -f $${PROJECT_NAME}-$${VERSION}/.gitignore &&
dist.commands += mkdir -p $${PROJECT_NAME}-$${VERSION}/ts &&
dist.commands += lupdate $${TRANSLATIONS} -ts $${PROJECT_NAME}-$${VERSION}/ts/$${PROJECT_NAME}.ts &&
dist.commands += tar jcpvf $${PROJECT_NAME}-$${VERSION}.tar.bz2 $${PROJECT_NAME}-$${VERSION} &&
dist.commands += rm -fR $${PROJECT_NAME}-$${VERSION}
QMAKE_EXTRA_TARGETS += dist

