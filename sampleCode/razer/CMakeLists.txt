cmake_minimum_required(VERSION 2.6 FATAL_ERROR)
set(PROJECT razer)
set(CMAKE_BUILD_TYPE Debug)
set(HEADERS
  src/Razer.h
)
set(SOURCES
  src/main.cpp
  src/Razer.cpp
)
set(RESOURCES
#  res.qrc
)

project(${PROJECT} CXX)

find_package(Qt4 REQUIRED)
include_directories(${QT_INCLUDES} ${CMAKE_CURRENT_BINARY_DIR})

qt4_automoc(${SOURCES})
#qt4_add_resources(QRC ${RESOURCES})

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/ui DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

add_definitions ("-DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED")
if (CMAKE_COMPILER_IS_GNUCXX)
  set (CMAKE_CXX_FLAGS_RELEASE "-m64 -march=native -mtune=generic -O2 -pipe -Wall -W -D_REENTRANT")
  set (CMAKE_EXE_LINKER_FLAGS "-m64 -Wl,--hash-style=gnu -Wl,--as-needed -Wl,-O1")
endif(CMAKE_COMPILER_IS_GNUCXX)

add_executable(${PROJECT} ${HEADERS} ${SOURCES})
target_link_libraries(${PROJECT} ${QT_QTCORE_LIBRARY} ${QT_QTGUI_LIBRARY} ${QT_QTDECLARATIVE_LIBRARY})
install(TARGETS ${PROJECT} DESTINATION ${CMAKE_INSTALL_PREFIX}/${PROJECT})
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/ui DESTINATION ${CMAKE_INSTALL_PREFIX}/${PROJECT})