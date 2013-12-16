import QtQuick 2.0

Rectangle {
    id: root
    border.color: "white"
    border.width: showBorder ? 1 : 0
    color: "transparent"
    property string contentType // "camera" or "video"
    property string source
    property real volume
    property bool dummy: false
    property bool autoStart: true
    property bool started: false
    property bool showFrameRate: false
    property bool showBorder: false

    signal initialized
    signal error
    signal videoFramePainted

    Loader {
        id: contentLoader
    }

    Connections {
        id: framePaintedConnection
        onFramePainted: {
            if (frameRateLoader.item)
                frameRateLoader.item.notify()
            root.videoFramePainted()
        }
        ignoreUnknownSignals: true
    }

    Connections {
        id: errorConnection
        onFatalError: {
            console.log("[qmlvideo] Content.onFatalError")
            stop()
            root.error()
        }
        ignoreUnknownSignals: true
    }

    Loader {
        id: frameRateLoader
        source: root.showFrameRate ? "../frequencymonitor/FrequencyItem.qml" : ""
        onLoaded: {
            item.parent = root
            item.anchors.top = root.top
            item.anchors.right = root.right
            item.anchors.margins = 10
        }
    }

    onWidthChanged: {
        if (contentItem())
            contentItem().width = width
    }

    onHeightChanged: {
        if (contentItem())
            contentItem().height = height
    }

    function initialize() {
        console.log("[qmlvideo] Content.initialize: contentType " + contentType)
        if ("video" == contentType) {
            console.log("[qmlvideo] Content.initialize: loading VideoItem.qml")
            contentLoader.source = "VideoItem.qml"
            if (Loader.Error == contentLoader.status) {
                console.log("[qmlvideo] Content.initialize: loading VideoDummy.qml")
                contentLoader.source = "VideoDummy.qml"
                dummy = true
            }
            contentLoader.item.volume = volume
        } else if ("camera" == contentType) {
            console.log("[qmlvideo] Content.initialize: loading CameraItem.qml")
            contentLoader.source = "CameraItem.qml"
            if (Loader.Error == contentLoader.status) {
                console.log("[qmlvideo] Content.initialize: loading CameraDummy.qml")
                contentLoader.source = "CameraDummy.qml"
                dummy = true
            }
        } else {
            console.log("[qmlvideo] Content.initialize: error: invalid contentType")
        }
        if (contentLoader.item) {
            contentLoader.item.sizeChanged.connect(updateRootSize)
            contentLoader.item.parent = root
            contentLoader.item.width = root.width
            framePaintedConnection.target = contentLoader.item
            errorConnection.target = contentLoader.item
            if (root.autoStart)
                root.start()
        }
        console.log("[qmlvideo] Content.initialize: complete")
        root.initialized()
    }

    function start() {
        console.log("[qmlvideo] Content.start")
        if (contentLoader.item) {
            if (root.contentType == "video")
                contentLoader.item.mediaSource = root.source
            contentLoader.item.start()
            root.started = true
        }
    }

    function stop() {
        console.log("[qmlvideo] Content.stop")
        if (contentLoader.item) {
            contentLoader.item.stop()
            if (root.contentType == "video")
                contentLoader.item.mediaSource = ""
            root.started = false
        }
    }

    function contentItem() { return contentLoader.item }
    function updateRootSize() { root.height = contentItem().height }
}
