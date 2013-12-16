/*!
 * Author: Mengcong
 * Date: 2013.11.20
 * Details: GridView for videos' thumbnail.
 */

import QtQuick 2.0

GridView {
    id: gridView

    signal clickedthumbnail(string filename)
    signal pressLong

    delegate: Column {
        Image {
            id: thumbnail
            source: "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/GridVideoThumbnail.jpg"

            MouseArea {
                anchors.fill: thumbnail
                onClicked: {
                    console.log("++++onCLicked++++")
                    //gridView.clickedthumbnail("file://" + gridView.model.getPath(index))
                    //gridView.model.currentIndex = index
                }

                onPressAndHold: {
                    console.log("++++onPressAndHold++++")
                    gridView.pressLong()
                }
            }

        }

        Text {
            id: videoName
            text: name
            //anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: videoDuration
            text: "00:00" // TODO: Get duration for each video.

        }

    }

}
