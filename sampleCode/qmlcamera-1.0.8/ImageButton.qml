import Qt 4.7

Item {
    id: button

    property alias source : image.source

    property int imageMargins: 0
    property real imageHorizontalAlignment : 0.0
    property int hMargin : 0
    property int vMargin : 0

    property alias text: text.text
    property alias textColor: text.color
    property real fontSize: 1.0

    signal clicked

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: button.clicked()
    }

    Item {
        id: buttonItem

        anchors.fill: parent
        anchors.leftMargin: hMargin
        anchors.rightMargin: hMargin
        anchors.topMargin: vMargin
        anchors.bottomMargin: vMargin

        Text {
            id: text

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            color: "white"
            font.pixelSize: (parent.height - imageMargins * 2) * fontSize

            visible: text != ""
        }

        Image {
            id: image

            x: text.visible ? text.x + text.width + imageHorizontalAlignment * width : parent.x + imageHorizontalAlignment * width

            width: text.visible ? parent.width - text.width - imageMargins * 2 : parent.width - imageMargins * 2
            height: parent.height - imageMargins * 2

            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
    }


}
