import QtQuick 2.0

Rectangle {
    id: playTopBar
    color: "black"
    // TODO: Need to pass the name.
    property string name: videoName.text

    signal clicked
    // TODO: May need to add visible property to
    // switch with "Select all" button
    TextButton {
        width: 80
        height: 40
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        text: "返回"
        onClicked: {
            console.log("press return button.")
            playTopBar.clicked()
        }
    }

    Text {
        id: videoName
        text: "葫芦小金刚" // TODO: It will be insteaded with playTopBar's name.
        color: "white"
        font.bold: true
        font.pixelSize: 20
        anchors.centerIn: parent
    }

}
