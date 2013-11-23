import QtQuick 2.0
import QtMultimedia 5.0

VideoOutput {
    source: mediaPlayer
    property alias mediaSource: mediaPlayer.source
    property alias volume: mediaPlayer.volume
    orientation: 90

    MediaPlayer {
        id: mediaPlayer
        autoPlay: true
        volume: 0.5
        loops: Audio.Infinite
    }

    function play() { mediaPlayer.play() }
    function stop() { mediaPlayer.stop() }
    function getPosition() { mediaPlayer.position() }
    function getDuration() { mediaPlayer.duration() }
}
