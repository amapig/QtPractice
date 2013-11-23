import QtQuick 2.0

Rectangle {
    id: button
    width: 100
    height: 62
    radius: 5
    border.color: "gray"
    border.width: 1
    opacity: 1

    property string text: "Button"
    property bool flag: false

    signal clicked

    function toggle() {
        flag = !flag
    }

    Text {
        id: buttonText
        text: button.text
        font.pixelSize: 14;
        anchors.centerIn: parent
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            button.clicked();
        }

        onPressed: button.opacity = 0.5
        onReleased: button.opacity = 1
    }
}
