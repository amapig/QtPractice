/*!
 * Author: Mengcong
 * Date: 2013.11.21
 * Details: Player engine.
 */

import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    property alias mediaSource: mediaPlayer.source

    function play() {
        console.log("Play file = " + mediaPlayer.source);
        mediaPlayer.play()
    }

    function stop() { mediaPlayer.stop() }

    function pause() { mediaPlayer.pause() }

    function seek(position) {
        if (mediaPlayer.seekable) {
            mediaPlayer.seek(position)
        } else {
            console.log("Current file don't support seek.")
        }
    }

    function getPosition() { return mediaPlayer.position }

    function getDuration() { return mediaPlayer.duration }

    function isPlaying() {
        if(mediaPlayer.playbackState != MediaPlayer.PlayingState) {
            console.log("MediaPlayer is not playing.")
            return false
        } else {
            console.log("MediaPlayer is playing.")
            return true
        }
    }

    function setMediaSource(source) {
        mediaSource = source
    }

    function switchFillMode() {
        if(videoOutput.fillMode == VideoOutput.PreserveAspectFit) {
            console.log("11111")
            videoOutput.fillMode = VideoOutput.Stretch
        } else {
            console.log("22222")
            videoOutput.fillMode = VideoOutput.PreserveAspectFit
        }
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
