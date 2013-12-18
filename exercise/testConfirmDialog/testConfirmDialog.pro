include(skytree.pri)
# Add more folders to ship with the application, here
# DEPLOYMENTFOLDERS #
folder_01.source = qml/app
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01
# DEPLOYMENTFOLDERS_END #

# Additional import path used to resolve QML modules in Creator code model
# QML_IMPORT_PATH #
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Installation path
target.path = $$APP_ROOT

skytree.files = *.spec
desktop.files = *.desktop
desktop.path = /data/system/applications

INSTALLS += desktop

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
# REMOVE_NEXT_LINE (wizard will remove the include and append deployment.pri to qmlapplicationviewer.pri, instead) #
include(/usr/share/qtcreator/templates/shared/deployment.pri)
qtcAddDeployment()

OTHER_FILES += *.spec *.desktop


