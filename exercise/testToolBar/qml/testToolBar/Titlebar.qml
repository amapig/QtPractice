import QtQuick 2.0

Rectangle {
    id:titlebar
    color: "#d98686"
    property string title: qsTr("Global Videos")

    signal backsig()
    signal menusig()

    Text {
        id: idTitle
        color: "white"
//        anchors.left: backbtn.right
//        anchors.leftMargin: 20
//        anchors.right: menubtn.left
//        anchors.rightMargin: 20
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
        anchors.centerIn: parent

        text: title

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 25
    }

    ImageButton {
        id: backbtn
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.left: parent.right - 10
        anchors.leftMargin: 10
        width: parent.height
        height: parent.height
        source1: "qrc:/image/image/back.png"
        source2: "qrc:/image/image/back.png"

        MouseArea {
            anchors.fill: parent
            onReleased: {
                titlebar.backsig();
            }
        }

        Text {
            color: "white"
            anchors.centerIn: parent
            text: "History"
        }
    }

}
