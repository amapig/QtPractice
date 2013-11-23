import QtQuick 2.0

Rectangle {
    width: 360
    height: 360
    property bool isVisable : false
    Text {
        visible: isVisable
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }

    TextButton {
        width: 80
        height: 40
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: "Button 1"
        visible: true

        // response the press event for play history.
        onClicked: {
            isVisable = true;
            console.log("button 1");
        }
    }

    TextButton {
        width: 80
        height: 40
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: "Button 2"
        visible: isVisable

        onClicked: {
            isVisable = false;
            console.log("button 2");
            mcvisible.isVisible = true;
        }
    }

    McVisible {
        id: mcvisible
        anchors.bottom: parent.bottom
    }

}
