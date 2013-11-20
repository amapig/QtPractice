import QtQuick 2.0

Rectangle {
    width: 600
    height: 800

    Loader { id: contentLoader }

    Connections {
        id: videoFramePaintedConnection
        onFramePainted: {
            if (performanceLoader.item)
                root.videoFramePainted()
        }
        ignoreUnknownSignals: true
    }

    function openVideo(path) {
        console.log("[qmlvideofx] Content.openVideo \"" + path + "\"")
        //stop()
        contentLoader.source = "VideoControls.qml"
        videoFramePaintedConnection.target = contentLoader.item
        contentLoader.item.mediaSource = path
        contentLoader.item.volume = volume
        contentLoader.item.play()
        //updateSource()
    }

//    MouseArea {
//        id: playArea
//        anchors.fill: parent
//        onClicked: {
//            console.log("press play");
//            // For PC
//            // openVideo("/home/mengcong/Desktop/VID_20131111_181557.3gp")
//             openVideo("/home/mengcong/Desktop/VID_20131119_141601.3gp");

//            // For VM
//            //openVideo("/home/skytree/Videos/VID_20131119_141601.3gp");
//        }
//    }

}
