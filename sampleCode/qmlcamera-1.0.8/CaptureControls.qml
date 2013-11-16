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

FocusScope {
    id : captureControls

    property QtObject camera
    property alias settingsPaneWidth : captureButtonsColumn.width

    signal previewSelected

    Column {
        id: captureButtonsColumn
        spacing : 4
        anchors.right : parent.right
        anchors.rightMargin: 8
        anchors.top : parent.top
        anchors.topMargin: 48

        ImageButton {
            width : 48
            height: 48
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/icon-m-toolbar-camera.svg"
            onClicked: camera.captureImage()
            visible: camera.cameraMode == MeegoCamera.CaptureStillImage && camera.cameraState == MeegoCamera.ActiveState
        }

        ImageButton {
            width : 48
            height: 48
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/icon-m-camera-video-record.svg"
            visible: camera.cameraMode == MeegoCamera.CaptureVideo &&
                     camera.cameraState == MeegoCamera.ActiveState &&
                     (camera.recordingState == MeegoCamera.Stopped || camera.recordingState == MeegoCamera.Paused)
            onClicked: camera.record()
        }

        ImageButton {
            width : 48
            height: 48
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/icon-m-camera-pause.svg"
            visible: camera.cameraMode == MeegoCamera.CaptureVideo && camera.recordingState == MeegoCamera.Recording
            onClicked: camera.pauseRecording()
        }
    }

    Item {
        id: exposureDetails
        anchors.bottom : parent.bottom
        anchors.left : parent.left
        anchors.bottomMargin: 16
        anchors.leftMargin: 16
        height: childrenRect.height
        width: childrenRect.width

        visible : camera.lockStatus == MeegoCamera.Locked

        Rectangle {
            opacity: 0.4
            color: "black"
            anchors.fill: parent
        }

        Row {
            spacing : 16

            Text {
                text: "Av: "+camera.aperture.toFixed(1)
                font.pixelSize: 18
                color: "white"
                visible: camera.aperture > 0
            }

            Text {
                font.pixelSize: 18
                color: "white"
                visible: camera.shutterSpped > 0
                text: "Tv: "+printableExposureTime(camera.shutterSpeed)

                function printableExposureTime(t) {
                    if (t > 3.9)
                        return "Tv: "+t.toFixed() + "\"";

                    if (t > 0.24 )
                        return "Tv: "+t.toFixed(1) + "\"";

                    if (t > 0)
                        return "Tv: 1/"+(1/t).toFixed();

                    return "";
                }
            }

            Text {
                text: "ISO: "+camera.iso.toFixed()
                font.pixelSize: 18
                color: "white"
                visible: camera.iso > 0
            }
        }
    }

    ZoomControl {
        visible: camera.cameraState == MeegoCamera.ActiveState
        x : 0
        y : 0
        width : 100
        height: parent.height

        currentZoom: camera.digitalZoom
        maximumZoom: Math.min(4.0, camera.maximumDigitalZoom)
        onZoomTo: camera.setDigitalZoom(value)
    }
}
