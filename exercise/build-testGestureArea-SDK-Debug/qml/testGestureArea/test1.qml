import Qt.labs.gestures 2.0
GestureArea {
    Tap: {
        when: gesture.hotspot.x > gesture.hotspot.y
        onStarted: console.log("tap in upper right started")
        onFinished: console.log("tap in upper right completed")
    }
}
