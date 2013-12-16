/*!
 * Author: Mengcong
 * Date: 2013.11.20
 * Details: GridView for videos' thumbnail.
 */

import QtQuick 2.0

GridView {
    id: gridView

    signal clickedthumbnail(string filename)

    delegate: Column {
        Image {
            id: thumbnail
            // TODO: Set each video's thumbnail.
            source: "qml/testGridView/DefaultVideoThumbnail.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
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
