import QtQuick 2.0

Rectangle {
    id: helloMain
    width: 300
    height: 300
    color: backgroundColor

    Text {
        id: helloYellow
        anchors.centerIn: parent
        text: "Hello Yellow World!"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            helloMain.color = "blue"
            helloYellow.color = "red"
        }
    }
}
