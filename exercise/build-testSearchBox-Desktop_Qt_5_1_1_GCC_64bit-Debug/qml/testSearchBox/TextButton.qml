/*!
 * Author: Mengcong
 * Date: 2013.11.18
 * Details: Text button tool.
 */

import QtQuick 2.0

Rectangle {
    id: button

    radius: 5
    border.color: "gray"
    border.width: 1
    opacity: 1

    property string text: "Button"
    property bool flag: false

    signal clicked

    function toggle() {
        flag = !flag
    }

    Text {
        text: button.text
        font.pixelSize: 45
        font.bold: true
        anchors.centerIn: parent
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { button.clicked(); }
        onPressed: { button.opacity = 0.5 }
        onReleased: { button.opacity = 1 }
    }
}
