import QtQuick 2.0
import Qt.labs.gestures 1.0

Rectangle {
    width: 360
    height: 360

    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }

    GestureArea {
        id: gesture

        anchors.fill: parent

        onPan: {
            console.log("onPan")
        }

        onSwipe: {
            console.log("onSwipe")
        }

        onPinch: {
            console.log("onPinch")
        }

        onTap: {
            console.log("onTap")
        }
    }

}
