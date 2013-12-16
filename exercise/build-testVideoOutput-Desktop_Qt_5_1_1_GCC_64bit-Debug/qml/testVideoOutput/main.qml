import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    width: 800
    height: 600
    color: "black"

    MediaPlayer {
        id: player
        source: "/home/mengcong/Videos/1.3gp"
        autoPlay: true
        loops: 100
    }

    VideoOutput {
        id: videoOutput
        source: player
        anchors.fill: parent

        // fillMode: VideoOutput.Stretch
        // fillMode: videoOutput.PreserveAspectCrop
        fillMode: videoOutput.PreserveAspectFit
    }

    MouseArea {
        id: mose

        anchors.fill: parent

        onClicked: {
            videoOutput.fillMode == VideoOutput.PreserveAspectFit ?
                        videoOutput.fillMode = VideoOutput.Stretch :
                        videoOutput.fillMode = VideoOutput.PreserveAspectFit
        }
    }

}
