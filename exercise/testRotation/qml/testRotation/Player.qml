import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id: root
    function play() {
        console.log("media source = " + mediaPlayer.source);
        mediaPlayer.play()
    }

    function stop() { mediaPlayer.stop() }
    function pause() { mediaPlayer.pause() }
    function seek(position) { mediaPlayer.seek(position) }
    function getPosition() { return mediaPlayer.position }
    function getDuration() { return mediaPlayer.duration }
    function isPlaying() {
        if(mediaPlayer.playbackState != MediaPlayer.PlayingState) {
            return false
        } else {
            return true
        }
    }

    property alias mediaSource: mediaPlayer.source

    VideoOutput {
        source: mediaPlayer
        anchors.fill: parent
    }

    MediaPlayer {
        id: mediaPlayer
        volume: 0.5
        loops: Audio.Infinite
    }

}
