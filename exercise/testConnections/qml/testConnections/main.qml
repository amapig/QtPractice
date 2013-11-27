import QtQuick 2.0

Rectangle {
    id : root

    width: 360
    height: 360

    property alias mouseme: mouseArea

    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            console.log("1111")
        }
    }

}
