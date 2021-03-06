/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
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

import QtQuick 2.0
import com.nokia.meego 2.0
import "." 2.0

MouseArea {
    id: root

    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

    property alias title: header.children 
    default property alias content: contentField.data
    property alias buttons: header.children
    property alias header: header
    property Item visualParent
    property int status: DialogStatus.Closed

//    property alias acceptButtonText: acceptButton.text
 //   property alias rejectButtonText: rejectButton.text

    property alias acceptButton: acceptButton
    property alias rejectButton: rejectButton

    property alias acceptButtonEnabled: acceptButton.enabled
    property alias rejectButtonEnabled: rejectButton.enabled

    signal accepted
    signal rejected
    property QtObject platformStyle: SheetStyle {}

    //Deprecated, TODO Remove this on w13
    property alias style: root.platformStyle

    function reject() {
        close();
        rejected();
    }

    function accept() {
        close();
        accepted();
    }

    visible: status != DialogStatus.Closed;
    
    function open() {
        parent = visualParent || __findParent();
        sheet.state = "";
    }

    function close() {
        sheet.state = "closed";
    }

    function __findParent() {
        var next = parent;
        while (next && next.parent
               && next.objectName != "appWindowContent"
               && next.objectName != "windowContent") {
            next = next.parent;
        }
        return next;
    }

    function getButton(name) {
        for (var i=0; i<buttons.length; ++i) {
            if (buttons[i].objectName == name)
                return buttons[i];
        }
        return undefined;
    }

    Item {
        id: sheet

        //when the sheet is part of a page do nothing
        //when the sheet is a direct child of a PageStackWindow, consider the status bar
        property int statusBarOffset: (parent.objectName != "windowContent") ? 0
                                       : (typeof __statusBarHeight == "undefined") ? 0
                                       : __statusBarHeight
        width: parent.width
        height: parent.height - statusBarOffset

        y: statusBarOffset
        clip: true
        property int transitionDurationIn: 300
        property int transitionDurationOut: 450

        state: "closed"

        function transitionStarted() {
            status = (state == "closed") ? DialogStatus.Closing : DialogStatus.Opening;
        }

        function transitionEnded() {
            status = (state == "closed") ? DialogStatus.Closed : DialogStatus.Open;
        }

        states: [
            // Closed state.
            State {
                name: "closed"
                // consider input panel height when input panel is open
                PropertyChanges { target: sheet; y: !inputContext.softwareInputPanelVisible
                                                    ? height : inputContext.softwareInputPanelRect.height + height; }
            }
        ]

        transitions: [
            // Transition between open and closed states.
            Transition {
                from: ""; to: "closed"; reversible: false
                SequentialAnimation {
                    ScriptAction { script: if (sheet.state == "closed") { sheet.transitionStarted(); } else { sheet.transitionEnded(); } }
                    PropertyAnimation { properties: "y"; easing.type: Easing.InOutQuint; duration: sheet.transitionDurationOut }
                    ScriptAction { script: if (sheet.state == "closed") { sheet.transitionEnded(); } else { sheet.transitionStarted(); } }
                }
            },
            Transition {
                from: "closed"; to: ""; reversible: false
                SequentialAnimation {
                    ScriptAction { script: if (sheet.state == "") { sheet.transitionStarted(); } else { sheet.transitionEnded(); } }
                    PropertyAnimation { properties: "y"; easing.type: Easing.OutQuint; duration: sheet.transitionDurationIn }
                    ScriptAction { script: if (sheet.state == "") { sheet.transitionEnded(); } else { sheet.transitionStarted(); } }
                }
            }
        ]

        Rectangle{
            id: contentField
            color: "white"
            //source:"../img/selectItem.png"
            //source: platformStyle.background
            width: parent.width
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
        }

        Rectangle {
            id: header
            width: parent.width
            height: 90
            color: "white"
            anchors.top: parent.top
         /*   border {
                left: platformStyle.headerBackgroundMarginLeft
                right: platformStyle.headerBackgroundMarginRight
                top: platformStyle.headerBackgroundMarginTop
                bottom: platformStyle.headerBackgroundMarginBottom
            }
            source: platformStyle.headerBackground
           */
            /*
            SheetButton {
                id: rejectButton
                objectName: "rejectButton"

                anchors.left: parent.left
                anchors.leftMargin: root.platformStyle.rejectButtonLeftMargin
                anchors.verticalCenter: parent.verticalCenter
                visible: text != ""
                onClicked: close()
            }
            */
            BorderImage {
                id: rejectButton
                source: "../img/cancel_btn.png"
                signal clicked
                width: 130; height: 69
                border.left: 5; border.top: 5
                border.right: 5; border.bottom: 5
                anchors.left: parent.left
                anchors.leftMargin: 23
                anchors.topMargin: 9
                anchors.top: parent.top
                Text{
                    font.pixelSize:  36
                    color:  "#1ca72b"
                    text: qsTr("Cancel")
                    font.bold: true
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill:parent
                    onPressed: {
                        parent.source = "../img/cancel_btn_pre.png"
                    }
                    onReleased: {
                        parent.source = "../img/cancel_btn.png"
                        reject()
                    }
                    onCanceled: {
                        parent.source = "../img/cancel_btn.png"

                    }
                }
            }
            Label{
                text: qsTr("Add contact")
                //text: "新建联系人"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "black"
                font.pixelSize: 36
                font.bold: true
            }
            BorderImage {
                id: acceptButton
                source: "../img/accept_btn.png"
                width: 130; height: 69
                border.left: 5; border.top: 5
                border.right: 5; border.bottom: 5
                anchors.right: parent.right
                anchors.rightMargin: 23
                anchors.top: parent.top
                anchors.topMargin: 9
                Text{
                    font.pixelSize:  36
                    color:  "white"
                    text: qsTr("OK")
                    font.bold: true
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill:parent
                    onPressed: {
                        parent.source = "../img/accept_btn_pre.png"
                    }
                    onReleased: {
                        parent.source = "../img/accept_btn.png"
                        console.log("11111111111111111111111\n",acceptButton.enabled)
                        accept()
                    }
                    onCanceled: {
                        parent.source = "../img/accept_btn.png"

                    }
                }
            }
            /*
            SheetButton {
                id: acceptButton
                objectName: "acceptButton"
                anchors.right: parent.right
                anchors.rightMargin: root.platformStyle.acceptButtonRightMargin
                anchors.verticalCenter: parent.verticalCenter
                platformStyle: SheetButtonAccentStyle { }
                visible: text != ""
                onClicked: close()
            }
            */
            BorderImage {
                    id: data_company_line
                    source: "../img/line1px.png"
                    width:header.width
                    height: 1
                    anchors{
                        left:header.left
                        bottom:header.bottom
                    }
                }

            /*
            Component.onCompleted: {
                acceptButton.clicked.connect(accepted)
                rejectButton.clicked.connect(rejected)
            }
            */
        }
    }
}
