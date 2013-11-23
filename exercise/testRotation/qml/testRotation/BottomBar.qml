import QtQuick 2.0

Rectangle {
    id: playerControls

    color: "lightgray"
    property bool portrait: true
    property string srcUri: ""
    property Player qmlPlayer

    TimeBar {
        id: progressBox
        width: playerControls.width
        height: playerControls.height/3
        anchors.left: parent.left
        anchors.top: parent.top
        qmlPlayer: parent.qmlPlayer
    }

    Row {
        id: rowbtn
        anchors.top: progressBox.bottom
        anchors.topMargin: 5
        anchors.bottom: playerControls.bottom
        anchors.bottomMargin: 5
        spacing: 15
        anchors.horizontalCenter: playerControls.horizontalCenter

        // Previous button
        ImageButton {
            id:prevBtn
            anchors.verticalCenter: parent.verticalCenter
            source1: "qrc:/image/image/previous_1.png"
            source2: "qrc:/image/image/previous_2.png"
            onClicked: {
                // player.previous();
                // playQueue.previous();
                console.log("Previous video")
            }
        }

        // Play button
        ImageButton {
            anchors.verticalCenter: parent.verticalCenter
            source1: qmlPlayer.isPlaying()? "qrc:/image/image/pause_1.png" : "qrc:/image/image/play_1.png"
            source2: qmlPlayer.isPlaying() ? "qrc:/image/image/pause_2.png" : "qrc:/image/image/play_2.png"
            onClicked: {
                console.log("play/pause filename = " + srcUri)
                qmlPlayer.mediaSource = srcUri
                qmlPlayer.isPlaying() ? qmlPlayer.pause() : qmlPlayer.play();
            }
        }

        // Next button
        ImageButton {
            anchors.verticalCenter: parent.verticalCenter
            source1: "qrc:/image/image/next_1.png"
            source2: "qrc:/image/image/next_2.png"
            onClicked: {
                console.log("Next video")
                // player.next();
                // playQueue.next();
            }
        }
    }
}
