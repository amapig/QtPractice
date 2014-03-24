import QtQuick 2.0

Rectangle {
    color: "#11262B"
    width: 1080
    height: 1920

    Text {
        id: log
        anchors.fill: parent
        anchors.margins: 10
        font.pixelSize: 14
        color: "snow"
    }

    PinchArea {
        anchors.fill: parent

        property real initialDistance;
        property real switchValue;

        function distance(p1, p2){
            var dx = p2.x - p1.x;
            var dy = p2.y - p1.y;
            return Math.sqrt(dx*dx + dy*dy);
        }

        onPinchFinished: {
            console.log("PinchArea onPinchFinished" + "\n")
        }

        onPinchStarted: {
            console.log("PinchArea onPinchStarted" + "\n")
            initialDistance = distance(pinch.point1, pinch.point2)
            console.log("Initial distance = " + initialDistance)
        }

        onPinchUpdated: {
            console.log("PinchArea onPinchUpdated" + "\n")
            var newDistance = distance(pinch.point1, pinch.point2)
            console.log(" new instance : "+ newDistance + " : " + initialDistance)
        }

        MouseArea {
            anchors.fill: parent
            onCanceled: {
                console.log("MouseArea onCanceled" + "\n")
            }

            onClicked: {
                console.log("MouseArea onClicked" + "\n")
            }

            onDoubleClicked: {
                console.log("MouseArea onDoubleClicked" + "\n")
            }

            onEntered: {
                console.log("MouseArea onEntered" + "\n")
            }

            onExited: {
                console.log("MouseArea onExited" + "\n")
            }

            onPositionChanged: {
                console.log("MouseArea onPositionChanged x = " + mouseX + "  y = " + mouseY )
            }

            onPressAndHold: {
                console.log("MouseArea onPressAndHold" + "\n")
            }

            onPressed: {
                console.log("MouseArea onPressed" + "\n")
            }
            onReleased: {
                console.log("MouseArea onReleased" + "\n")
            }

        }
    }
}
