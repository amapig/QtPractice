import QtQuick 2.0

Flickable {
    width: 360
    height: 360
    contentWidth: image.width; contentHeight: image.height
    Image { id: image; source: "flickable.png" }

    onFlickDecelerationChanged: {
        console.log("onFlickDecelerationChanged")
    }

    onFlickEnded: {
        console.log("onFLickEnded")
    }

    onFlickStarted: {
        console.log("onFlickStarted")
    }

//    onFlickableChildrenChanged: {
//        console.log("onFlickableChildrenChanged")
//    }

//    onFlickableDataChanged: {
//        console.log("onFlickableDataChanged")
//    }

    onFlickableDirectionChanged: {
        console.log("onFlickableDirectionChanged")
    }

    onFlickingChanged: {
        console.log("onFlickingChanged")
    }

    onFlickingVerticallyChanged: {
        console.log("onFlickingVerticallyChanged")
    }

    onFlickingHorizontallyChanged: {
        console.log("onFlickingHorizontallyChanged")
    }

}
