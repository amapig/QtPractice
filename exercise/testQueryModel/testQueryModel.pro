HEADERS       = ../connection.h \
                customsqlmodel.h \
                editablesqlmodel.h \
    editablesqlmodel.h \
    customsqlmodel.h \
    connection.h
SOURCES       = customsqlmodel.cpp \
                editablesqlmodel.cpp \
                main.cpp \
    editablesqlmodel.cpp \
    customsqlmodel.cpp
QT           += sql widgets

# install
target.path = $$[QT_INSTALL_EXAMPLES]/sql/querymodel
INSTALLS += target
