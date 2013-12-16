import QtQuick 2.0

Rectangle {
    width: 360
    height: 360

    PinchArea {
        anchors.fill: parent

        onPinchFinished: {
            console.log("onPinchFinished")
        }

        onPinchStarted: {
            console.log("onPinchstarted")
        }

        onPinchUpdated: {
            console.log("onPinchUpdated")
        }
    }

}
