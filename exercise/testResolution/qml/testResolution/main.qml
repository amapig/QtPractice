import QtQuick 2.0

Rectangle {
    width: currentWidth
    height: currentHeight
    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {

        }
    }

}
