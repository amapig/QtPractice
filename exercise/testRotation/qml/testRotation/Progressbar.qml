import QtQuick 2.0

Item {
    property double value: 0.0
    property alias interactive: maProgressBar.enabled
    property int _userX;

    signal sigseek(double value)

    id: progressBar

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        color: "#a99d97"
        width: parent.width
        height: 6
        radius: 2
    }

    Rectangle {
        x: maProgressBar.pressed ? _userX - width / 2 : value * parent.width - width / 2
        anchors.verticalCenter: parent.verticalCenter
        width: 16
        height: 16
        radius: 8
        color: "white"

        Behavior on x {
            NumberAnimation { duration: 200 }
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
                console.log("++++pressed++++")
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
