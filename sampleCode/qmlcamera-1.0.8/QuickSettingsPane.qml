import Qt 4.7
import com.meego.MeegoHandsetCamera 1.0

Item {
    id: quickSettingsPane

    property QtObject camera
    property QtObject settings
    property QtObject propertyPopup

    Binding {
        target: settings
        property: "flashMode"
        value: flashModesButton.value
    }

    Binding {
        target: settings
        property: "whiteBalanceMode"
        value: wbModesButton.value
    }

    Binding {
        target: settings
        property: "exposureCompensation"
        value: exposureCompensationButton.value
    }


    Row {
        id: settingButtonsColumn
        spacing : 0
        anchors.fill: parent

        CameraPropertyButton {
            id : flashModesButton

            width: parent.height + parent.height * 2 / 3
            height: parent.height
            hMargin: parent.height / 3

            icon: flashModesButtonListModel.get(flashModesButtonModel.currentIndex()).icon

            visible: camera.cameraMode == MeegoCamera.CaptureStillImage

            model: CameraPropertyModel {
                id: flashModesButtonModel

                currentValue: settings.flashMode

                model: ListModel {
                    id: flashModesButtonListModel

                    ListElement {
                        icon: "images/icon-m-camera-flash-auto-screen.svg"
                        value: MeegoCamera.FlashAuto
                        text: "Auto"
                    }
                    ListElement {
                        icon: "images/icon-m-camera-flash-off-screen.svg"
                        value: MeegoCamera.FlashOff
                        text: "Off"
                    }
                    ListElement {
                        icon: "images/icon-m-camera-flash-always-screen.svg"
                        value: MeegoCamera.FlashOn
                        text: "On"
                    }
                    ListElement {
                        icon: "images/icon-m-camera-flash-red-eye-screen.svg"
                        value: MeegoCamera.FlashRedEyeReduction
                        text: "Red Eye Reduction"
                    }
                }

            }
            onClicked: propertyPopup.toggleOn(flashModesButton.model)

        }

        CameraPropertyButton {
            id : wbModesButton

            width: parent.height + parent.height * 2 / 3
            height: parent.height
            hMargin: parent.height / 3

            icon: wbModesButtonListModel.get(wbModesButtonModel.currentIndex()).icon

            model: CameraPropertyModel {
                id: wbModesButtonModel

                currentValue: settings.whiteBalanceMode

                model: ListModel {
                    id: wbModesButtonListModel

                    ListElement {
                        icon: "images/icon-m-camera-whitebalance-auto-screen.svg"
                        value: MeegoCamera.WhiteBalanceAuto
                        text: "Auto"
                    }
                    ListElement {
                        icon: "images/icon-m-camera-whitebalance-sunny-screen.svg"
                        value: MeegoCamera.WhiteBalanceSunlight
                        text: "Sunlight"
                    }
                    ListElement {
                        icon: "images/icon-m-camera-whitebalance-cloudy-screen.svg"
                        value: MeegoCamera.WhiteBalanceCloudy
                        text: "Cloudy"
                    }
                    ListElement {
                        icon: "images/icon-m-camera-whitebalance-tungsten-screen.svg"
                        value: MeegoCamera.WhiteBalanceIncandescent
                        text: "Incandescent"
                    }
                    ListElement {
                        icon: "images/icon-m-camera-whitebalance-fluorescent-screen.svg"
                        value: MeegoCamera.WhiteBalanceFluorescent
                        text: "Fluorescent"
                    }
                }
            }

            onClicked: propertyPopup.toggleOn(wbModesButton.model)

        }

        CameraPropertyButton {
            id : exposureCompensationButton

            width: parent.height * 2 + parent.height * 3 / 4
            height: parent.height
            hMargin: parent.height / 3
            fontSize: 0.66
            imageMargins: 0

            icon: exposureCompensationButtonListModel.get(exposureCompensationButtonModel.currentIndex()).icon
            text: "Ev:"

            model: CameraPropertyModel {
                id: exposureCompensationButtonModel

                currentValue: settings.exposureCompensation

                model: ListModel {
                    id: exposureCompensationButtonListModel
                    ListElement {
                        icon: "images/icon-m-camera-exposure-minus2.svg"
                        value: -2.0
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-minus17.svg"
                        value: -1.7
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-minus1.svg"
                        value: -1.0
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-minus07.svg"
                        value: -0.7
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-minus03.svg"
                        value: -0.3
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-0.svg"
                        value: 0.0
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-plus03.svg"
                        value: 0.3
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-plus07.svg"
                        value: 0.7
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-plus1.svg"
                        value: 1.0
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-plus13.svg"
                        value: 1.3
                        text: ""
                    }
                    ListElement {
                        icon: "images/icon-m-camera-exposure-plus2.svg"
                        value: 2.0
                        text: ""
                    }
                }
            }

            onClicked: propertyPopup.toggleOn(exposureCompensationButton.model)
        }
    }

}
