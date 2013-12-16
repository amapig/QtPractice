
import QtQuick 2.0

Scene {
    id: root
    property string contentType

    Content {
        id: content
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        contentType: "video"
        source: parent.source1
        volume: parent.volume
        state: "left"

        states: [
            State {
                name: "nonFullScreen"
                PropertyChanges { target: content; width: content.parent.contentWidth }
            }
        ]

        transitions: [
            Transition {
                ParallelAnimation {
                    PropertyAnimation {
                        property: "width"
                        easing.type: Easing.Linear
                        duration: 250
                    }
                    PropertyAnimation {
                        property: "height"
                        easing.type: Easing.Linear
                        duration: 250
                    }
                }
            }
        ]

        MouseArea {
            anchors.fill: parent
            onClicked: content.state = (content.state == "nonFullScreen") ? "baseState" : "nonFullScreen"
        }

        onVideoFramePainted: root.videoFramePainted()

        onInitialized: {
            width = parent.width
            height = parent.height
        }
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            margins: 20
        }
        text: "Tap on the content to toggle full-screen mode"
        color: "yellow"
        font.pixelSize: 20
        z: 2.0
    }

    Component.onCompleted: root.content = content
}

