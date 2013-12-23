/*!
 * Author: Mengcong
 * Date: 2013.11.22
 * Details: Controls of player.
 */

import QtQuick 2.0
import "config.js" as Config

Rectangle {
    id: playerControls

    property bool portrait: true
    property Player qmlPlayer

    signal sigplay()
    signal sigprevious()
    signal signext()

    color: "lightgray"

    function formatTime(t) {
        t = t / 1000;
        var secs = Math.floor(t % 60);
        t = t / 60;
        var mins = Math.floor(t % 60);
        t = t / 60;
        var hours = Math.floor(t);
        if (secs < 10) secs = "0" + secs;
        if (mins < 10) mins = "0" + mins;
        if (hours < 10) hours = "0" + hours;

        return hours + ":" + mins + ":" + secs;
    }

    ProgressBar {
        id: progressBar

        width: parent.width
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        value: qmlPlayer.getPosition() / qmlPlayer.getDuration()

        onSigseek: {
            var millisecs = qmlPlayer.getDuration() * position;
            qmlPlayer.seek(millisecs);
        }
    }

    Text {
        id: currentPosition

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: progressBar.bottom
        anchors.topMargin: 15
        horizontalAlignment: Text.AlignRight
        color: "#1ca72b"
        text: formatTime(qmlPlayer.getPosition())
        font.pixelSize: 22
    }

    Text {
        id: duration

        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: progressBar.bottom
        anchors.topMargin: 15
        horizontalAlignment: Text.AlignRight
        color: "#787777"
        text: formatTime(qmlPlayer.getDuration())
        font.pixelSize: 22
    }

    Item {
        id: controlBtn
        width: playerControls.width
        height: 125
        anchors.top: progressBar.bottom
        anchors.topMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15

        Row {
            id: rowbtn

            spacing: 60
            anchors.centerIn: controlBtn

            ImageButton {
                id: preBtn

                width: 110
                height: 110
                source1: "qrc:/qml/qml/houtui2.png"
                source2: "qrc:/qml/qml/houtui2-active.png"

                onClicked: {
                    playerControls.sigprevious()
                }
            }

            ImageButton {
                id: playBtn

                width: 110
                height: 110
                source1: qmlPlayer.isPlaying() ? "qrc:/qml/qml/zanting2.png" : "qrc:/image/image/bofang2.png"
                source2: qmlPlayer.isPlaying() ? "qrc:/qml/qml/zanting2-active.png" : "qrc:/image/image/bofang2-active.png"

                onClicked: {
                    playerControls.sigplay()
                }
            }

            ImageButton {
                id: nextBtn

                width: 110
                height: 110
                source1: "qrc:/qml/qml/qianjin2.png"
                source2: "qrc:/qml/qml/qianjin2-active.png"

                onClicked: {
                    playerControls.signext()
                }
            }
        }
    }

}
