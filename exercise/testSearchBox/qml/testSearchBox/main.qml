import QtQuick 2.0

Rectangle {
    width: 600
    height: 800

    property bool isVisible : false

    ThumbnailsView {
        id: thumbnailsView

        width: parent.width
        height: parent.height

        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 15  // TODO: think about this value later.

        cellWidth: thumbnailsView.width/3
        cellHeight: thumbnailsView.height/3

        model: globalPlayQueue

        onPressLong: {
            isVisible = true
        }
    }

    BottomBar {
        id: bottomBar

        width: parent.width
        height: parent.height/12

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        visible: isVisible

        onSigDelete: {
            globalPlayQueue
        }
    }

}
