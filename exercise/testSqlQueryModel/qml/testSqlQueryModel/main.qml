import QtQuick 2.0

Rectangle {
    width: 1080
    height: 1920
    MouseArea {
        anchors.fill: parent

        Text {
            id: text1
            anchors.verticalCenterOffset: 20
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Testing")
            font.pixelSize: 12
        }

        ListView {
            id: list_view1
            x: 125
            y: 100
            width: 110
            height: 160
            delegate: ArtistItemDelegate {}
            model: artistsModel
        }
    }
}
