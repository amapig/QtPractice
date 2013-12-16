import QtQuick 2.0

Rectangle {
    width: 360
    height: 360

    ListView {
        id: list
        width: 180; height: 200
        anchors.right: parent.right
        anchors.rightMargin: 5

        model: ListModel {
            ListElement {
                name: "Bill Smith"
                number: "555 3264"
            }
            ListElement {
                name: "John Brown"
                number: "555 8426"
            }
            ListElement {
                name: "Sam Wise"
                number: "555 0473"
            }
            ListElement {
                name: "Sam Wise"
                number: "555 0473"
            }
            ListElement {
                name: "Sam Wise"
                number: "555 0473"
            }
        }

        delegate:  Column {
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/GridVideoThumbnail.jpg"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: name
            }
        }

        // highlight: highlight
        highlightFollowsCurrentItem: false
        focus: true
    }

}


