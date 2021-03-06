import QtQuick 1.1

Item {
    id: container
    property alias cellColor: rectangle.color
    signal clicked(color cellColor)
    width: 30; height: 25
    Rectangle {
        id: rectangle
        border.color: "red"
        anchors.fill: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: container.clicked(container.cellColor)
    }
}
