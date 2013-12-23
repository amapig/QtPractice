/*!
 * Author: Mengcong
 * Date: 2013.12.21
 * Details: Player engine.
 */

import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    function setMediaSource(source) {
        mediaPlayer.source = source
    }

    function play() {
        console.log("Play file = " + mediaPlayer.source)
        mediaPlayer.play()
    }

    function stop() {
        mediaPlayer.stop()
    }

    function seek(position) {
        mediaPlayer.seek(position)
    }

    VideoOutput {
        id: videoOutput

        source: mediaPlayer
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectFit
    }

    MediaPlayer {
        id: mediaPlayer
        volume: 0.5
    }

}
