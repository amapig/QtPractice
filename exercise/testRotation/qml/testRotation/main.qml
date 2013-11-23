import QtQuick 2.0

Rectangle {
    id: playingInterface

    width: 800
    height: 600

    property string filename
    signal sigback

    // TODO: Must be horizontal screen.
    // rotation: 90

    function previous() {
    }

    function next() {
    }

    // Useful logs.
    /*Component.onCompleted: {
        console.log("parent: " + mediaPlayer.parent.width + " " + mediaPlayer.height);
        console.log("mediaplayer: " + mediaPlayer.width  + " " + mediaPlayer.height + " " + mediaPlayer.left + " " + mediaPlayer.right);
        console.log("playingTopBar: " + playingTopBar.width  + " " + playingTopBar.height + " " + playingTopBar.left + " " + playingTopBar.right);
        console.log("playerControl: " + playerControl.width  + " " + playerControl.height + " " + playerControl.left + " " + playerControl.right);
    }*/

    Player {
        id: mediaPlayer

        width: parent.width
        height :parent.height - playingTopBar.height - playerControl.height

        anchors.top: playingTopBar.bottom
        anchors.topMargin: 5
        anchors.bottom: playerControl.top
        anchors.bottomMargin: 5
        anchors.left: parent.left
    }

    TopBar {
        id: playingTopBar

        width: parent.width
        height: parent.height * 1/6

        anchors.top: parent.top
        //anchors.topMargin: 5
        anchors.left: parent.left
        //anchors.leftMargin: 5

        onClicked: {
            console.log("press return bar")
            playingInterface.sigback()
            // When press return button, video should be stopped.
            mediaPlayer.stop()
        }
    }

    BottomBar {
        id: playerControl

        width: parent.width * 4/5
        height: parent.height * 1/5

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        //rotation: 90
    }

}
