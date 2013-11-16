import QtQuick 2.0

Item {
    id: toptitleBarItem

    property string titleText: "Sample Video Player"

    Rectangle{
        id:titleRect
        anchors.fill: toptitleBarItem
        color: "cyan"
        border.color: "black"
        border.width:5
        Text {
            id: titleText
            text: toptitleBarItem.titleText
            anchors.centerIn: titleRect
            font.pointSize: 8
            font.bold: true
            color: "black"
        }
    }
}
