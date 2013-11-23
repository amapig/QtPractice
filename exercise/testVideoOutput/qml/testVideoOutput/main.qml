import QtQuick 2.0

Rectangle {
    width: 500
    height: 500

    Player {
        id: mediaPlayer
        width: parent.width
        height: parent.width * 3 /4
        anchors.top: parent.top
        anchors.topMargin: 5
        //anchors.bottom: playerControl.top
        //anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            // mediaPlayer.stop()
            console.log("clicked");
            mediaPlayer.mediaSource = "/home/mengcong/Videos/VID_20131119_141601.3gp"
            mediaPlayer.play()
        }
    }
}
