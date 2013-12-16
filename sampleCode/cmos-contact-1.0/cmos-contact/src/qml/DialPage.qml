/****************************************************************************
**
** Copyright (C) 2011-2012 Tom Swindell <t.swindell@rubyx.co.uk>
** All rights reserved.
**
** This file is part of the Voice Call UI project.
**
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
**   * The names of its contributors may NOT be used to endorse or promote
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
**
****************************************************************************/
import QtQuick 2.0
import com.nokia.meego 2.0

Page {
    id:root
    clip:true

    height:parent.height-49
    width:parent.width

    orientationLock:PageOrientation.LockPortrait

    property alias numberEntryText: numentry.text

    Rectangle {
        color: "white"
        anchors.fill: parent
    }

    
    function addPhoneNumber(strPhoneNumber)
    {
        numentry.text = strPhoneNumber
    }


    HistoryPage{
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top:numentry.bottom
        anchors.topMargin: 50
        anchors.bottom: callActions.top

        focus: false

    }


    NumberEntry {
        id:numentry
        y:50

        anchors {

            left:parent.left;right:parent.right
        }
        color:'#ffffff'

    }
    FeatureRow{
        id:callActions
        width:root.width;height:144
        state:"hide"
        anchors {bottom:parent.bottom;horizontalCenter:parent.horizontalCenter;margins:30}


    }

    Rectangle{
        id:numtable
        anchors {bottom:callActions.top;left:parent.left}
        height:numpad.height+20
        width:parent.width

        color:"transparent"

        NumPad {
            id:numpad

            width:root.width-16;height:childrenRect.height
            anchors {bottom:parent.bottom;left:parent.left;leftMargin: 8;rightMargin:8;topMargin: 0}

            entryTarget:numentry
            z:1
        }

        Image {
            z:0
            id:numberBorder
            height:40
            width:parent.width
            source:'image/border.png'
            anchors{top: parent.top}
            opacity:0.8
        }

    }


}
