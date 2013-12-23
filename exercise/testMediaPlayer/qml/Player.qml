/*!
 * Author: Mengcong
 * Date: 2013.11.21
 * Details: Player engine.
 */

import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    function play() {
        console.log("Player::Play file = " + mediaPlayer.source);
        mediaPlayer.play()
    }

    function stop() { mediaPlayer.stop() }

    function pause() { mediaPlayer.pause() }

    function seek(position) {
        console.log("Player::seek position = " + position)
        mediaPlayer.seek(position)
    }

    function getPosition() { return mediaPlayer.position }

    function getDuration() { return mediaPlayer.duration }

    function isPlaying() {
        if(mediaPlayer.playbackState !== MediaPlayer.PlayingState) {
            console.log("MediaPlayer is not playing.")
            return false
        } else {
            console.log("MediaPlayer is playing.")
            return true
        }
    }

    function setMediaSource(source) {
        mediaPlayer.source = source
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
