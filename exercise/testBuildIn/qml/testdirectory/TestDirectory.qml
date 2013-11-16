import QtQuick 2.0

Rectangle {
    width: 200; height: 200
    color: "red"

    MouseArea {
        anchors.fill: parent
        onClicked: console.log("Button clicked!")
    }
}
