import QtQuick 2.0
import Thumbnailer 1.0

Rectangle {
    width: 800
    height: 800

    Image {
        id: originImage
        anchors.top: parent.top
        x: 10
        sourceSize.width: 200
        sourceSize.height: 200
    }

    Thumbnail {
        id: thumbnail
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
                imageIndex++;
                // getThumbnails();
            }
        }
    }

    property int imageIndex: 0
    property int cacheImageIndex: imageIndex

    Timer {
        id: timer
        interval: 200; // a long time
        running:true
        repeat: true
        onTriggered: {
            getThumbnails();
        }
    }

    function getThumbnails() {
        if (imageIndex == 0 || imageIndex != cacheImageIndex) { // I have 24 pictures.
            console.log("++++"+ imageIndex + ":" + playQueue.getPath(imageIndex) + "++++");
            thumbnail.source = playQueue.getPath(imageIndex);
            cacheImageIndex = imageIndex;
        }
    }

    //    MouseArea {
    //        id: mouseArea
    //        anchors.fill: parent
    //        onClicked: {
    //            getThumbnails()
    //        }
    //    }

}
