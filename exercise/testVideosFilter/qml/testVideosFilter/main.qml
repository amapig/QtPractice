import QtQuick 2.0

Rectangle {
    id: main
    width: 600
    height: 800

    VideosGridView {
        id: thumbnailsView

        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5

        onClickedthumbnail: {
            console.log("Click: " + filename)
            mainInterface.clicked(filename)
        }
    }

}
