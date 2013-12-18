import QtQuick 2.0

Rectangle {
    width: 800
    height: 1280

    Rectangle{
        id:optArea
        width: parent.width
        height: parent.height
        color: "grey"
    }

    PinchArea{
        anchors.fill: parent

        property real initialDistance;
        property real scale

        function distance(p1, p2){
            var dx = p2.x - p1.x;
            var dy = p2.y - p1.y;
            return Math.sqrt(dx*dx + dy*dy);
        }

        onPinchStarted: {
            initialDistance = distance(pinch.point1,pinch.point2);
            print("initialDistance initialDistance initialDistance initialDistance : " + initialDistance)
        }

        onPinchUpdated: {
            //pinch.previousCenter.x
            //pinch.previousCenter.y
            //pinch.center.x
            //pinch.center.y

            var newDistance = distance(pinch.point1, pinch.point2)
            print(" scale scale scale scale scale scale 1 : "+ newDistance + " : " + initialDistance)

            if(newDistance != 0)
                scale = newDistance / initialDistance;

            print(" scale scale scale scale scale scale 2 : "+scale)
        }

        onPinchFinished: {
            print("33333333 : " + scale);
        }
    }


}

