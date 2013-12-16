import QtQuick 2.0

Rectangle {
    id: bottomBar

    signal sigShare
    signal sigDelete

    TextButton {
        id: shareBtn

        width: parent.width/2
        height: parent.height
        text: "分享"
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: deleteBtn.left
        anchors.rightMargin: 5
        anchors.bottom: parent.Bottom

        // TODO: Response the search event.
        onClicked: {
            console.log("Share button!")
        }
    }

    TextButton {
        id: deleteBtn

        width: parent.width/2
        height: parent.height
        text: "删除"
        anchors.left: shareBtn.right
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom

        // TODO: Response the search event.
        onClicked: {
            console.log("Delete button!")
            bottomBar.sigDelete()
        }
    }
}
