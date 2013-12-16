import QtQuick 2.0

GridView {
    id: gridView

    signal clickedthumbnail(string filename)

    delegate: Column {
        Image {
            id: thumbnail

            width: gridView.width/3.3
            height: gridView.width/3.3

            // TODO: Set each video's thumbnail.
            source: "qrc:/image/image/GridVideoThumbnail.jpg"
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: thumbnail
                onClicked: {
                    gridView.clickedthumbnail("file://" + gridView.model.getPath(index))
                    gridView.model.currentIndex = index
                }
            }
        }

        Text {
            id: videoName
            text: name
            font.bold: true
            font.pixelSize: 35
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: videoDuration
            text: "00:00" // TODO: Get duration for each video.
            font.pixelSize: 25
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

}
