import QtQuick 2.0
import Thumbnailer 1.0

Rectangle {
    width: 360
    height: 360

    Image {
        id: originImage
        anchors.top: parent.top
        x: 10
        sourceSize.width: 200
        sourceSize.height: 200
    }

    Thumbnail {
        id: thumbnail
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        x: 10
        sourceSize.width: 200
        sourceSize.height: 200

        onSourceChanged:  {
            console.log("++++onSourceChanged++++");
        }

        onMimeTypeChanged: {
            console.log("++++onMimeTypeChanged++++");
        }

        onSourceSizeChanged: {
            console.log("++++onSourceSizeChanged++++");
        }

        onFillModeChanged: {
            console.log("++++onFillModeChanged++++");
        }

        onPriorityChanged: {
            console.log("++++onPriorityChanged++++");
        }

        onStatusChanged: {
            console.log("++++onStatusChanged++++");
            if (status == 1) {
                console.log("1111111111111111111111111");
                imageIndex++;
                // getThumbnails();
            }
        }
    }

    property int imageIndex: 0
    property int cacheImageIndex: imageIndex

//    Timer {
//        id: timer
//        interval: 200; // a long time
//        running:true
//        repeat: true
//        onTriggered: {
//            getThumbnails();
//        }
//    }

    function getThumbnails() {
        if (imageIndex == 0 || imageIndex != cacheImageIndex) { // I have 24 pictures.
            // console.log("++++"+ imageIndex + ":" + playQueue.getPath(imageIndex) + "++++");
            // thumbnail.source = playQueue.getPath(imageIndex);
            thumbnail.source = "file:///home/mengcong/Videos/1.3gp"
            // thumbnail.source = "file:///home/mengcong/Pictures/1.jpg"
            cacheImageIndex = imageIndex;
        }
    }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                getThumbnails()
            }
        }

}
