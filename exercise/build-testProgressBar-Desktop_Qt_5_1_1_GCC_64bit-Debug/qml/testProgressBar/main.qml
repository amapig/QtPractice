import QtQuick 2.0

Rectangle {
    width: 600
    height: 800

    TimeBar {
        id: progressBox

        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
    }

}
