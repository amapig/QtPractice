/*!
 * Author: Mengcong
 * Date: 2013.11.22
 * Details: Progress bar.
 */

import QtQuick 2.0
import "config.js" as Config

Item {
    id: progressBar

    property double value: 0.0
    property alias interactive: maProgressBar.enabled
    property int _userX;

    signal sigseek(double position)

    Rectangle {
        width: parent.width
        height: Config.CONTROL_PROGRESS_BAR_HEIGHT
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
    }

    Rectangle {
        width: value * parent.width
        height: Config.CONTROL_PROGRESS_BAR_HEIGHT
        anchors.verticalCenter: parent.verticalCenter
        x: 0
        color: "green"

        Behavior on x {
            NumberAnimation { duration : 20 }
        }
    }

    Image {
        x: maProgressBar.pressed ? _userX - width / 2 : value * parent.width - width / 2
        anchors.verticalCenter: parent.verticalCenter
        width: Config.CONTROL_PROGRESS_CURSOR
        height: Config.CONTROL_PROGRESS_CURSOR
        source: "qrc:/qml/qml/progress_cursor_1.png"

        Behavior on x {
            NumberAnimation { duration: 20 }
        }
    }

    MouseArea {
        id: maProgressBar

        anchors.fill: parent
        onPressed: {
            console.log("Press progress bar")
            progressBar._userX = Math.min(width, Math.max(0, mouseX));
        }

        onPositionChanged: {
            console.log("Position changed")
            if (pressed) {
                console.log("Pressed")
                progressBar._userX = Math.min(width, Math.max(0, mouseX));
            }
        }

        onReleased: {
            console.log("Release progress bar")
            var value = Math.min(width, Math.max(0, mouseX)) / width;
            progressBar.sigseek(value);
        }
    }
}
