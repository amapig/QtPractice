import QtQuick 2.0

Rectangle {
    width: 360
    height: 360

    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (stopwatch.isRunning())
            {
                console.log("stop")
                stopwatch.stop()
            }
            else
            {
                console.log("start")
                stopwatch.start()
            }
        }
    }
}
