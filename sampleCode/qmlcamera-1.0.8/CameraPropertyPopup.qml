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

Rectangle {
    id: propertyPopup

    property CameraPropertyModel model

    radius: 5
    border.color: "#000000"
    border.width: 2
    smooth: true
    color: "#5e5e5e"
    visible: opacity > 0
    opacity: 0

    signal selected

    function toggleOn(newModel) {
        model = newModel
        view.currentIndex = model.currentIndex()
        opacity = 1.0
    }

    function close() {
        opacity = 0.0
    }

    GridView {
        id: view
        model: propertyPopup.model.model

        anchors.fill: parent
        anchors.topMargin: 6
        anchors.leftMargin: 6
        anchors.rightMargin: 6
        anchors.bottomMargin: parent.height / 3

        cellWidth: view.width / view.model.count + 1
        cellHeight: view.height

        snapMode: ListView.SnapOneItem
        boundsBehavior: Flickable.StopAtBounds
        flow: GridView.TopToBottom

        highlightFollowsCurrentItem: true
        highlight: Rectangle { color: "gray"; radius: 5 }

        delegate: ImageButton {
            id: delegateButton
            width: view.width / view.model.count + 1
            height: view.height
//            imageWidth: width - 12
//            imageHeight: height - 12
            imageMargins: 6

            source: icon

            onClicked: {
                propertyPopup.model.currentValue = value
                propertyPopup.selected()
            }
        }

    }

    Text {
        id: text
        anchors.top: view.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 6
        anchors.bottomMargin: 6
        anchors.left: parent.left
        anchors.leftMargin: 16

        color: "#ffffff"
        font.bold: true
        style: Text.Raised;
        styleColor: "black"
        font.pixelSize: text.height

        text: view.model.count > 0 ? view.model.get(view.currentIndex).text : ""
    }
}
