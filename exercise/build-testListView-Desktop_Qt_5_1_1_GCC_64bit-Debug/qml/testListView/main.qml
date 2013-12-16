import QtQuick 2.0

Rectangle {
    width : 600
    height: 800
    property bool isVisible : false

    TestListView {
        id: testListView
        visible: isVisible

        width: parent.width/4
        height: parent.height
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.bottom: parent.bottom

    }

    // open button
    ImageButton {
        width: rowbtn.width/12
        height: rowbtn.height
        anchors.right: parent.right
        visible: !isVisible

        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        source1: isVisible ? "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/next_1.png" :
                             "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/previous_1.png"
        source2: isVisible ? "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/next_2.png" :
                             "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/previous_2.png"

        onClicked: {
            isVisible = true
        }
    }

    // close button
    ImageButton {
        width: rowbtn.width/12
        height: rowbtn.height
        anchors.right: testListView.left
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: isVisible

        source1: isVisible ? "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/next_1.png" :
                             "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/previous_1.png"
        source2: isVisible ? "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/next_2.png" :
                             "/home/mengcong/workspace/player/cmos-videoplayer/cmos-videoplayer/image/previous_2.png"

        onClicked: {
            isVisible = false
        }
    }
}
