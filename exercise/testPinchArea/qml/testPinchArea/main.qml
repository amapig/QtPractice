import QtQuick 2.0

Rectangle {
    id: root
    color: "#11262B"
    width: 600
    height: 800

    //    Flickable {
    //        anchors.fill: parent
    //        width: root.width; height: root.height
    //        contentWidth: root.width; contentHeight: root.height
    //        Image { id: image; source:  "transparent.png" }

    //        onFlickingHorizontallyChanged: {
    //            console.log("horizontally changed.")
    //        }

    //        onFlickingVerticallyChanged: {
    //            console.log("vertical changed.")
    //        }

    PinchArea {
        anchors.fill: parent

        property real initialDistance;
        property real switchValue;

        function distance(p1, p2) {
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

            property int originalX;
            property int originalY;
            property int distanceX;
            property int distanceY;

            onCanceled: {
                console.log("MouseArea onCanceled" + "\n")
            }

            onClicked: {
                console.log("MouseArea onClicked x = " + mouseX + "  y = " + mouseY )
            }

            onDoubleClicked: {
                console.log("MouseArea onDoubleClicked" + "\n")
            }

            onPressed: {
                console.log("MouseArea onPressed x = " + mouseX + "  y = " + mouseY )
                originalX = mouseX;
                originalY = mouseY;
            }
            onReleased: {
                console.log("MouseArea onReleased x = " + mouseX + "  y = " + mouseY )
                distanceX = mouseX - originalX;
                distanceY = mouseX - originalY;

                if (Math.abs(distanceX) >= Math.abs(distanceY)) {
                    // Resize process
                    console.log("resize process")
                    if (distanceX  < 0) {
                        console.log("kill process")
                    } else {
                        console.log("add process")
                    }
                } else {
                    // Resize column
                    console.log("resize column")
                    if (distanceY < 0) {
                        console.log("kill column")
                    } else {
                        console.log("add column")
                    }
                }
            }
        }
    }
    //    }

}
