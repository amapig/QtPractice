import QtQuick 2.0

Rectangle {
    width: 360
    height: 360

    TextButton {
        width: 80
        height: 40
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: "Left"

        // TODO: Response the press event for play history.
        onClicked: {
            console.log("Search button!");
        }
    }
}
