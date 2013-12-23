/*!
 * Author: Mengcong
 * Date: 2013.11.21
 * Details: Playing interface of player.
 */

import QtQuick 2.0
import QtMultimedia 5.0
import com.cmos.widget 1.0
import com.nokia.meego 2.0

Page {
    id: playingInterface

    property string filename

    width: parent.width
    height: parent.height

    orientationLock: PageOrientation.LockLandscape

    Component.onCompleted: {
        mediaPlayer.setMediaSource("/home/skytree/jipinfeiche.mp4")
        mediaPlayer.play()

        console.log("PlayingInterface insert new: "
                    + filename + "|||"
                    + mediaPlayer.getDuration() + "|||"
                    + mediaPlayer.getPosition());
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
            historyModel.updatePosition(filename, mediaPlayer.getPosition())
            //TODO: Need to update lasttime.
            historyModel.refresh()

            mediaPlayer.stop()
            pageStack.pop()
        }
    }

}
