/***************************************************************************
    Copyright (C) 2013 by CMOS
    Author: ZhaoDongshuang
    Email: zhaodongshuang@cmos.net
    Date: 2013-12-04
    File: ShadowText.qml
    // 主要用于给文字增加阴影
 ***************************************************************************/
import QtQuick 2.0

Item {
    property alias text: realTxt.text
    property alias font: realTxt.font

    width: realTxt.width; height: realTxt.height;

    Text {
        text: realTxt.text; color: "#045F1E"; font: realTxt.font;
        x: realTxt.x + 1; y: realTxt.y + 1;
    }
    Text {
        id: realTxt; color: "#48C46B"; font.pixelSize: 24;
        anchors { centerIn: parent; }
    }
}
