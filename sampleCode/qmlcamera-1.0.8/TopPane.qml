import Qt 4.7

Item {

    property QtObject camera
    property QtObject settings
    property QtObject propertyPopup

    property alias quickSettingsVisible : quickSettings.visible

    QuickSettingsPane {
        id: quickSettings

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.rightMargin: 6

        camera: parent.camera
        settings: parent.settings
        propertyPopup: parent.propertyPopup
    }
}
