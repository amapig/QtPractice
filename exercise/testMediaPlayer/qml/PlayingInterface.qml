/*!
 * Author: Mengcong
 * Date: 2013.11.21
 * Details: Playing interface of player.
 */

import QtQuick 2.0
import QtMultimedia 5.0
import com.cmos.widget 1.0
import com.nokia.meego 2.0

CMOS_Page {
    id: playingInterface

    property string filename
    property bool isVisable : false

    orientationLock: PageOrientation.LockLandscape

    Component.onCompleted: {
        mediaPlayer.setMediaSource(filename)
        mediaPlayer.play()
    }

    Player {
        id: mediaPlayer

        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        MouseArea {
            anchors.fill: parent
            onClicked: {
                isVisable == false ? isVisable = true : isVisable = false
                timer.stop()
                timer.start()
            }
        }
    }

    CMOS_TopTitleBar {
        id: playingTopBar

        anchors.top: parent.top
        anchors.left: parent.left
        enableLeft: true
        enableMiddle: true
        enableRight: true
        visible: isVisable
        leftText: ""
        rightBorderWidth: 1
        rightIcon: ""
        title: qsTr(filename.substring(filename.lastIndexOf("/") + 1, filename.length))

        onLTrigger: {
            mediaPlayer.stop()
            pageStack.pop()
        }
    }

    PlayerControls {
        id: playerControl

        qmlPlayer: mediaPlayer
        width: parent.width
        height: 150
        visible: isVisable
        anchors.left:  parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        onSigplay: {
            console.log("Play, filename = " + playingInterface.filename)
            mediaPlayer.mediaSource = playingInterface.filename
            mediaPlayer.isPlaying() ? mediaPlayer.pause() : mediaPlayer.play()
        }

        onSigprevious: {
            mediaPlayer.seek(mediaPlayer.getPosition() - 5000) // 5 secs
        }

        onSignext: {
            mediaPlayer.seek(mediaPlayer.getPosition() + 5000)
        }
    }

    Timer {
        id: timer

        interval: 5000; // 5 secs.
        onTriggered: {
            isVisable = false;
        }
    }

}
