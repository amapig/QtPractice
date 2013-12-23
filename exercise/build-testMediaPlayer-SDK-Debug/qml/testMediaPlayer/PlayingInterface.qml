/*!
 * Author: Mengcong
 * Date: 2013.12.21
 * Details: Playing interface of player.
 */

import QtQuick 2.0
import QtMultimedia 5.0
import com.cmos.widget 1.0
import com.nokia.meego 2.0

CMOS_Page {
    id: playingInterface

    property string filename

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
    }

    CMOS_TopTitleBar {
        id: playingTopBar

        anchors.top: parent.top
        anchors.left: parent.left
        enableLeft: true
        enableMiddle: true
        enableRight: true
        leftText: ""
        rightBorderWidth: 1
        rightIcon: ""
        title: qsTr(filename.substring(filename.lastIndexOf("/") + 1, filename.length))

        onLTrigger: {
            mediaPlayer.stop()
            pageStack.pop()
        }
    }
}
