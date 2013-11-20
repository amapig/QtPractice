import QtQuick 2.0

//Rectangle {
//    id: myRect
//    width: 100; height: 100
//    color: "black"

//    MouseArea {
//        id: mouseArea
//        anchors.fill: parent
//        onClicked: myRect.state == 'clicked' ? myRect.state = "" : myRect.state = 'clicked';
//    }

//    states: [
//        State {
//            name: "clicked"
//            PropertyChanges { target: myRect; color: "red" }
//        }
//    ]
//}

Rectangle {
    id: signalswitch
    width: 75; height: 75
    color: "blue"

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (signal.state == "NORMAL")
                signal.state = "CRITICAL"
            else
                signal.state = "NORMAL"
        }
    }
}
