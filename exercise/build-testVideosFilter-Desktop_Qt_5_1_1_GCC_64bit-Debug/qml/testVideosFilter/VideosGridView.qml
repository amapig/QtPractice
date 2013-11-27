import QtQuick 2.0

GridView {
    id: gridView

    cellWidth: thumbnailsView.width/3
    cellHeight: thumbnailsView.height/3

    signal clickedthumbnail(string filename)

    model: playQueue
    delegate: Column {
        Image {
            id: thumbnail
            source: "file:///home/mengcong/workspace/codes/exercise/testVideosFilter/qml/testVideosFilter/GridVideoThumbnail.jpg"

            MouseArea {
                anchors.fill: thumbnail
                onClicked: {
                    gridView.clickedthumbnail("file://" + playQueue.getPath(index))
                    playQueue.currentIndex = index
                }
            }
        }

        Text {
            id: videoName
            text: name
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: videoDuration
            text: "00:00" // TODO: Get duration for each video.
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

}
