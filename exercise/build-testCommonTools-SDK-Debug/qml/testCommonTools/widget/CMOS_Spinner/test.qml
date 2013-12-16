/***************************************************************************
    Copyright (C) 2013 by CMOS
    Author: ZhaoDongshuang
    Email: zhaodongshuang@cmos.net
    Date: 2013-11-13
    File: test.qml
 ***************************************************************************/
import QtQuick 2.0

Item{
    width: 600; height: 200;

    SpinnerBase{
        anchors.fill: parent

        anchors.margins: 6;
        // test use background
        /*
          注意：若使用“background”属性，则必须要有一个背景，
               可以使用空背景，或者不设置“background”属性
        */
        background: backgroudSource;
        // test use model
        model: modelSource
        // test Rotation and test currentIndex() interface
        textRotation: (currentIndex() % 2) ? -10 : 10
        // test fontPixelSize
        pixelSize: parent.height*3/5;
        // test currentData() interface

        onCurrentIndexChenged: {
            console.log("currentText ================= ",currentText());
        }

        Component.onCompleted: {//show currentText when the application start
            console.log("currentText ================= ",currentText());
        }
    }

    Component{ // 可以使用任何的资源放在 backgroudSource 作为背景
        id: backgroudSource

        // ================================= test background 0 空背景

//        Item{}

        // ================================= test background 1

        Rectangle{
            radius: 20;
            gradient: Gradient{
                GradientStop{ position: 0.0; color: "black" }
                GradientStop{ position: 0.18; color: "gray" }
                GradientStop{ position: 0.33; color: "white" }
                GradientStop{ position: 0.66; color: "gray" }
                GradientStop{ position: 1.0; color: "black" }
            }
        }

        // ================================= test background 2

//        Rectangle{
//            color: "lightGreen"
//        }

        // ================================= test background 3

//        Image {
//            source: "filePath"
//        }
    }

    ListModel { // 可以使用任何的字符为content赋值
        id: modelSource

        // example data 1

//        ListElement { content: "2" }
//        ListElement { content: "3" }
//        ListElement { content: "4" }

        // example data 2

        ListElement { content: "星期一" }
        ListElement { content: "星期二" }
        ListElement { content: "星期三" }
        ListElement { content: "星期四" }
        ListElement { content: "星期五" }
        ListElement { content: "星期六" }
        ListElement { content: "星期日" }
    }
}

