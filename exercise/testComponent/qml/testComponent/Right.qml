import QtQuick 2.0

Rectangle {
    width: 360
    height: 360

    TextButton {
        width: 80
        height: 40
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: "right"

        // TODO: Response the press event for play history.
        onClicked: {
            console.log("Search button!");
        }
    }
}
