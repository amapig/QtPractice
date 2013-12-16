import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    // property alias qmlPlayer: mediaPlayer
    property alias mediaSource: mediaPlayer.source

    function play() {
        console.log("media source = " + mediaSource);
        console.log("mediaPlayer.source = " + mediaPlayer.source);
        mediaPlayer.play()
    }
    function stop() { mediaPlayer.stop() }
    function pause() { mediaPlayer.pause() }
    function seek(position) { mediaPlayer.seek(position) }

    function getPosition() { mediaPlayer.position() }
    function getDuration() { mediaPlayer.duration() }

    VideoOutput {
        source: mediaPlayer
        anchors.fill: parent
        //property alias mediaSource: mediaPlayer.source
        //property al ias volume: mediaPlayer.volume
        // TODO: Must be horizontal screen.
        // orientation: 90
    }

    MediaPlayer {
        id: mediaPlayer
        //autoPlay: true
        volume: 0.5
        loops: Audio.Infinite
    }
}
