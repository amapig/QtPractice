/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the examples of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import Qt 4.7
import QtMultimediaKit 1.1
import com.meego.MeegoHandsetCamera 1.0

Rectangle {
    id : cameraUI
    color: "black"
    state: "Standby"

    property alias imagePath : camera.capturedImagePath

    signal deleteImage

    // This defines "active" state. For example when state is
    // "Capture" active state is also "Capture" but
    // when state changes to "Standby" active state remains as
    // "Capture". When the app returns from "Standby"
    // state the active state will be activated.
    property string activeState: "Capture"

    // Lens cover status
    // true = lens cover open
    // false = lens cover closed
    property bool lensCoverStatus: true

    // Is the app active i.e. is it the top most
    // window with focus. If screen is shut down
    // or closed the app is not active
    // true = active
    // false = not active
    property bool active : false

    property alias videoModeEnabled: bottomPane.videoModeEnabled

    states: [
        State {
            name: "Standby"
            StateChangeScript {
                script: {
                    captureControls.visible = false
                    bottomPane.visible = false
                    photoPreview.visible = false
                    camera.visible = false
                }
            }
        },
        State {
            name: "Capture"
            StateChangeScript {
                script: {
                    captureControls.visible = true
                    bottomPane.visible = true
                    photoPreview.visible = false
                }
            }
        },
        State {
            name: "PhotoPreview"
            StateChangeScript {
                script: {
                    captureControls.visible = false
                    bottomPane.visible = false
                    photoPreview.visible = true
                    photoPreview.focus = true
                    camera.visible = false
                }
            }
        }
    ]

    // Activates given state
    function changeState(newState)
    {
        if(newState == state)
            return

        if(newState == "Standby") {
            toggleStandby(true)
        } else {
            activeState = newState

            if(active)
                state = newState
        }
    }

    // Toggles "Standby" state on/off
    function toggleStandby(standbyStatus)
    {
        if(standbyStatus && state != "Standby") {
            // Go to standby mode
            activeState = state
            state = "Standby"
        } else if(!standbyStatus && state == "Standby" && active) {
            // Wake up from standby mode
            state = activeState
        }
    }

    onStateChanged: {
        if(state == "Standby") {
            camera.cameraState = "UnloadedState"
        } else if(state == "Capture") {

            if(lensCoverStatus) {
                camera.cameraState = "ActiveState"
                camera.visible = true
                camera.focus = true
            } else {
                if( camera.cameraState = "ActiveState" )
                    camera.cameraState = "UnloadedState"

                camera.focus = false
                camera.visible = false
            }
        }
    }

    onLensCoverStatusChanged: {

        if(!lensCoverStatus) {
            if( camera.cameraState = "ActiveState" )
                camera.cameraState = "UnloadedState"
        } else if(state == "Capture") {
            camera.cameraState = "ActiveState"
            camera.focus = true
        }
    }

    onActiveChanged: {
        toggleStandby(!active)
    }

    CameraSettings {
        id: settings
    }

    MouseArea {
        anchors.fill: parent

        onPressed: { // User tapped vf background
            // First priority is to close open popup/menus
            if(cameraPropertyPopup.visible) {
                cameraPropertyPopup.close()
            } else if(camera.cameraMode == MeegoCamera.CaptureStillImage) {
                // If no popup open let's lock/unlock camera
                if(camera.lockStatus == MeegoCamera.Unlocked)
                    camera.searchAndLock()
                else
                    camera.unlock()
            }
        }
    }

    MeegoCamera {
        id: camera
        objectName: "camera"
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        focus: false
        visible: false
        cameraState: "UnloadedState"
        cameraMode: settings.cameraMode

        captureResolution : settings.captureResolution
        videoCaptureResolution: settings.videoCaptureResolution

        videoEncodingQuality: settings.videoEncodingQuality
        
        previewResolution : camera.width + "x" + camera.height
        viewfinderResolution: settings.viewfinderResolution

        flashMode: settings.flashMode
        whiteBalanceMode: settings.whiteBalanceMode
        exposureCompensation: settings.exposureCompensation

        onImageCaptured : {
            photoPreview.source = preview
            bottomPane.previewAvailable = true
            changeState("PhotoPreview")
        }

        onCameraStateChanged : {
            visible = true
        }

        Keys.onPressed : {
            if (event.key == Qt.Key_Camera || event.key == Qt.Key_WebCam ) {
                // Capture button fully pressed
                event.accepted = true;

                if(camera.cameraMode == MeegoCamera.CaptureVideo) {
                    if(camera.recordingState == MeegoCamera.Recording)
                        //camera.pauseRecording();
                        camera.stopRecording();
                    else
                        camera.record();
                } else {
                    // Take still image
                    camera.captureImage();
                }

            } else if (event.key == Qt.Key_ZoomIn || event.key == Qt.Key_F7 || event.key == Qt.Key_VolumeDown ) {
                // Zoom in
                event.accepted = true;
                zoomOutAnimation.stop();
                zoomInAnimation.duration = 4000 - camera.digitalZoom / Math.min(4.0, camera.maximumDigitalZoom) * 4000;
                zoomInAnimation.start();
            } else if (event.key == Qt.Key_ZoomOut || event.key == Qt.Key_F8 || event.key == Qt.Key_VolumeUp ) {
                // Zoom out
                event.accepted = true;
                zoomInAnimation.stop();
                zoomOutAnimation.duration = 4000 * camera.digitalZoom / Math.min(4.0, camera.maximumDigitalZoom);
                zoomOutAnimation.start();
            }
        }
        
        Keys.onReleased : {
            if (event.key == Qt.Key_ZoomIn || event.key == Qt.Key_F7 || event.key == Qt.Key_VolumeDown ) {
                // Zoom in
                event.accepted = true;
                zoomInAnimation.stop();
            } else if (event.key == Qt.Key_ZoomOut || event.key == Qt.Key_F8 || event.key == Qt.Key_VolumeUp) {
			    // Zoom out
			    event.accepted = true;
			    zoomOutAnimation.stop();
			}
        }
        
        PropertyAnimation {
            id: zoomInAnimation;
            target: camera;
            property: "digitalZoom";
            to: Math.min(4.0, camera.maximumDigitalZoom);
            duration: 4000;
        }
        
        PropertyAnimation {
            id: zoomOutAnimation;
            target: camera;
            property: "digitalZoom";
            to: 0.0;
            duration: 4000;
        }
    }

    Text {
        id: infoText
        visible: text != ""
        color: "white"
        font.pixelSize: 36
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text:  {
            if( parent.state == "Standby") {
                "Standby"
            } else {
                if(!lensCoverStatus)
                    "Lens cover closed"
                else if(camera.resourcesStatus == MeegoCamera.ResourcesDenied)
                    "Busy"
                else if(camera.error != MeegoCamera.NoError)
                    "Error"
                else
                    ""
            }
        }
    }

    CaptureControls {
        id: captureControls
        anchors.top: topPane.bottom
        anchors.bottom: bottomPane.top
        anchors.left: parent.left
        anchors.right: parent.right
        camera: camera
    }

    CameraPropertyPopup {
        id: cameraPropertyPopup

        height: 96
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topPane.bottom
        anchors.topMargin: 6
        anchors.rightMargin: captureControls.settingsPaneWidth
        anchors.leftMargin: captureControls.settingsPaneWidth

        // Initialize with empty model
        model: CameraPropertyModel {
            ListModel {}
        }

        transitions: Transition {
            NumberAnimation { properties: "opacity"; duration: 100 }
        }

        onSelected: {
            close()
        }
    }

    PhotoPreview {
        id : photoPreview
        anchors.fill : parent
        onClosed: changeState("Capture")
        focus: visible

        onDeleteImage: {
            parent.deleteImage()
            closed()
        }

        Keys.onPressed : {
            //return to capture mode if the shutter button is touched
            if (event.key == Qt.Key_CameraFocus || event.key == Qt.Key_WebCam ) {
                closed()
                event.accepted = true;
            }
        }


    }

    TopPane {
        id: topPane

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        anchors.margins: 6
        height: 48

        camera: camera
        settings: settings
        propertyPopup: cameraPropertyPopup

        quickSettingsVisible : cameraUI.state == "Capture"
    }

    BottomPane {
        id: bottomPane

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 6
        height: 48

        camera: camera
        settings: settings

        onPreviewSelected: changeState("PhotoPreview")
    }


    onDeleteImage: {
      bottomPane.previewAvailable = false
    }


}
