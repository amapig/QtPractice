import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {

    function play() {
        mediaPlayer.source = "file:///home/mengcong/Videos/VID_20131119_141601.3gp"
        console.log("media source = " + mediaPlayer.source);
        mediaPlayer.play()
    }

    function stop() { mediaPlayer.stop() }
    function pause() { mediaPlayer.pause() }
    function seek(position) { mediaPlayer.seek(position) }
    function getPosition() { mediaPlayer.position() }
    function getDuration() { mediaPlayer.duration() }

    property alias mediaSource: mediaPlayer.source
    property bool isPlay

    VideoOutput {
        source: mediaPlayer
        anchors.fill: parent
    }

    MediaPlayer {
        id: mediaPlayer
        autoPlay: true
        volume: 0.5
        loops: Audio.Infinite

        onPlaying: {
            console.log("onPlaying")
        }

        onStopped: {
            console.log("onStopped")
        }

        onPaused: {
            console.log("onPaused")
        }
    }

}
