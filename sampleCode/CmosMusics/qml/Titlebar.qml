import QtQuick 2.0

Rectangle {
    id:titlebar
    color: "#d98686"
    property string title: qsTr("All Musics")

    signal backsig()
    signal menusig()

    ImageButton {
        id: backbtn        
        anchors.left: parent.left
        anchors.top: parent.top
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
    }

    Text {
        id: idTitle
        anchors.left: backbtn.right
        anchors.leftMargin: 20
        anchors.right: menubtn.left
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        text: title

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 50
    }

    ImageButton {
        id: menubtn
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: parent.height
        height: parent.height
        source1: "qrc:/image/image/menu.png"
        source2: "qrc:/image/image/menu.png"
        MouseArea {
            anchors.fill: parent
            onReleased: {
                titlebar.menusig();
            }
        }
    }
}
