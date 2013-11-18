import QtQuick 2.0

Item{
    id:toolbarButtonItem
    property alias buttonColor:button.color
    property string buttonText: buttonText.text

    signal buttonClicked()

    Rectangle{
        id:button
        color: buttonColor
        anchors.fill: toolbarButtonItem
        border.color: "black"
        border.width: 5

        Text{
            id:buttonText
            color: "black"
            font.pointSize: 6
            font.bold: true
            text: toolbarButtonItem.buttonText
            anchors.centerIn: button
        }

        MouseArea{
            id:buttonMouseArea
            anchors.fill: button
            onClicked: toolbarButtonItem.buttonClicked()

            onPressed: button.opacity = 0.5
            onReleased: button.opacity = 1
        }
    }
}
