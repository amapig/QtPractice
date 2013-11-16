import Qt 4.7
import QtMultimediaKit 1.1
import com.meego.MeegoHandsetCamera 1.0

Item {

    property QtObject camera
    property QtObject settings
    property bool videoModeEnabled: false
    property bool previewAvailable : false

    signal previewSelected

    ImageButton {
        id: viewButton

        source: "images/icon-m-toolbar-gallery.svg"

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        width: viewButton.height

        onClicked: previewSelected()

        visible: camera.cameraMode == MeegoCamera.CaptureStillImage && previewAvailable
    }

    ImageButton {
        id: modeButton

        source: camera.cameraMode == MeegoCamera.CaptureVideo ? "images/icon-m-toolbar-camera.svg" : "images/icon-m-camera-video.svg"

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        width: modeButton.height

        onClicked: {
            if( camera.cameraMode != MeegoCamera.CaptureStillImage )
                settings.cameraMode = MeegoCamera.CaptureStillImage
            else
                settings.cameraMode = MeegoCamera.CaptureVideo
        }

        visible: videoModeEnabled
    }
}
