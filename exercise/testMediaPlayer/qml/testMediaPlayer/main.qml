import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    width: 480
    height: 270

    MediaPlayer {
        id: player
        source: "/home/mengcong/Desktop/VID_20131111_181557.3gp" // Point this to a suitable video file
        autoPlay: true
        loops: 5
    }

    VideoOutput {
        source: player
        anchors.fill: parent
    }
}
