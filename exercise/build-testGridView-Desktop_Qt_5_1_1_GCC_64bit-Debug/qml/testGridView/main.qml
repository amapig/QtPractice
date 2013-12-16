import QtQuick 2.0

Rectangle {
    width: 600
    height: 800

    Thumbnailers {
        id: thumbnailsView

        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left

        cellWidth: thumbnailsView.width/3
        cellHeight: thumbnailsView.height/3
    }
}
