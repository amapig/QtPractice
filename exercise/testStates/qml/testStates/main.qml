import QtQuick 2.0

Rectangle {
    id: signal
    width: 200; height: 200
    state: "STOP"

    function setPlayState() {signal.state = "PLAY"}
    function setPauseState() {signal.state = "PAUSE" }
    function setStopState() {signal.state = "STOP" }

    states: [
        State {
            name: "PLAY"
            StateChangeScript {
                script: {
                    console.log("play")
                }
            }
        },

        State {
            name: "PAUSE"
            StateChangeScript {
                script: {
                    console.log("pause")
                }
            }
        },

        State {
            name: "STOP"
            StateChangeScript {
                script: {
                    console.log("stop")
                }
            }
        }
    ]

    Player {
        id: mediaPlayer
        width: parent.width
        height: parent.height * 3 /4
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.bottom: playerControl.top
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
    }

    TextButton {
        width: 80
        height: 40
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        text: "play"
        onClicked: {
            console.log("press play button.")
            mediaPlayer.play()
        }
    }
    TextButton {
        width: 80
        height: 40
        anchors.centerIn: parent
        //anchors.verticalCenter: parent.verticalCenter
        text: "pause"
        onClicked: {
            console.log("press pause button.")
            mediaPlayer.pause()
        }
    }
    TextButton {
        width: 80
        height: 40
        anchors.right: parent.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        text: "stop"
        onClicked: {
            console.log("press stop button.")
            mediaPlayer.stop()
        }
    }
}
