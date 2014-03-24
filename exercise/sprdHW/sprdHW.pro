#-------------------------------------------------
#
# Project created by QtCreator 2014-03-24T10:53:31
#
#-------------------------------------------------

QT       += core

QT       -= gui

TARGET = sprdHW
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app

INCLUDEPATH += /usr/include/glib-2.0/ \
               /usr/local/lib/glib-2.0/include/ \
                /home/mengcong/workspace/cmos/multimedia/gstreamer/gst-omx/omx/openmax

LIBS += /usr/local/lib/libglib-2.0.so

SOURCES += /home/mengcong/workspace/git/sprdavcdecoder/8830/dec/sprdomxh264dec.c\
/home/mengcong/workspace/git/sprdavcdecoder/8830/dec/SPRDAVCDecoder.cpp\
/home/mengcong/workspace/git/sprdavcdecoder/8830/dec/SPRDAVCDecoder.h\
/home/mengcong/workspace/git/sprdavcdecoder/8830/dec/avc_dec_api.h\
/home/mengcong/workspace/git/sprdavcdecoder/8830/dec/sprdomxh264dec.h\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/SprdOMXComponent.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/OMXMaster.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/SimpleSoftOMXComponent.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/SoftOMXComponent.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/SoftOMXPlugin.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/OMXNodeInstance.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/OMX.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/tests/OMXHarness.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/SprdSimpleOMXComponent.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/SprdOMXPlugin.cpp\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/SoftOMXPlugin.h\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/SprdOMXPlugin.h\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/tests/OMXHarness.h\
/home/mengcong/workspace/spreadtrum/idh.code/frameworks/av/media/libstagefright/omx/OMXMaster.h\
