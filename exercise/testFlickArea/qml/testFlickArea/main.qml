import QtQuick 2.0

Rectangle {
    id: root
    width: 360
    height: 360

    Text {
        id: name
        anchors.centerIn: root
        text: qsTr("nihaoma ")
    }
//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//            console.log("hello root")
//        }
//    }

    Rectangle {
        id: cell
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("hello mengcong")
            }
        }
    }
}
