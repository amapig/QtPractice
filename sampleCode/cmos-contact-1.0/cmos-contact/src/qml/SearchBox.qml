/****************************************************************************
 **
 ** Copyright (C) 2012 Robin Burchell <robin+mer@viroteck.net>
 ** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
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

Item {
    id: root

    // Declared properties
    property alias searchText: searchTextInput.text
    property alias placeHolderText: searchTextInput.placeholderText
    property alias maximumLength: searchTextInput.maximumLength
    property alias activeFocus2: searchTextInput.activeFocus
    // Styling for the SearchBox
    property Style platformStyle: ToolBarStyle {}

    // Signals & functions
    signal backClicked
    signal addNewContact

    // Attribute definitions
    width: parent ? parent.width : 0
    height: 89
    //height: bgImage.height


    // SearchBox background.
    /*
    BorderImage {
        id: bgImage
        width: root.width
        border.left: 10
        border.right: 10
        border.top: 10
        border.bottom: 10
        source: platformStyle.background
    }
    */
    Rectangle{
        id:background
        anchors.fill: root
        color: "white"
    }
    BorderImage {
        id:line
        source: "../img/line1px.png"
        width:root.width
        height: 1
        anchors{
            left:root.left
            bottom:root.bottom
        }
    }
    BorderImage {
        id: newContact
        source: "../img/new.png"
        width:50; height:50
        border.left: 5; border.top: 5
        border.right: 5; border.bottom: 5
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        MouseArea{
            anchors.fill: parent
            onReleased: {
                root.addNewContact()
                parent.source=  "../img/new.png"
            }
            onPressed:
                parent.source=  "../img/new_pre.png"
            onCanceled:
                parent.source=  "../img/new.png"
        }

    }
    TextField {
        id: searchTextInput

        // Helper function ripped from QQC platform sources. Used for
        // getting the correct URI for the platform toolbar images.
        function __handleIconSource(iconId) {
            var prefix = "icon-m-"
            // check if id starts with prefix and use it as is
            // otherwise append prefix and use the inverted version if required
            if (iconId.indexOf(prefix) !== 0)
                iconId =  prefix.concat(iconId).concat(theme.inverted ? "-white" : "");
            return "image://theme/" + iconId;
        }

        inputMethodHints: Qt.ImhNoPredictiveText
        height: 72

        anchors {
            left: parent.left
            right:newContact.left
            verticalCenter: parent.verticalCenter
           // margins: UiConstants.DefaultMargin
            leftMargin: 40
            rightMargin: 20
            topMargin: 9
            bottomMargin: 9
        }

        // Save some empty space for the text on the left & right,
        // for the icon graphics.
        platformStyle: TextFieldStyle {
            paddingLeft: searchIcon.width + UiConstants.DefaultMargin * 1.5 // 2 is mathematically correct, but looks too big.
            paddingRight: clearTextIcon.width
        }

        // Search icon, just for styling the SearchBox a bit.
        Image {
            id: searchIcon

            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                margins: UiConstants.DefaultMargin
            }

            fillMode: Image.PreserveAspectFit
           // source: searchTextInput.__handleIconSource("toolbar-search")
            source: "../img/search.png"
        }

        // A trash can image, clicking it allows the user to quickly
        // remove the typed text.
        Image {
            id: clearTextIcon

            anchors {
                right: parent.right
                rightMargin: UiConstants.DefaultMargin
                verticalCenter: parent.verticalCenter
            }

            fillMode: Image.PreserveAspectFit
            source: searchTextInput.__handleIconSource("toolbar-delete")
            visible: searchTextInput.text.length > 0

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    searchTextInput.text = ""
                    searchTextInput.forceActiveFocus()
                }
            }
        }
    }
}
