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

Item {
    id:root

    property alias text:textedit.text
    property alias color:textedit.color
    property alias alignment:textedit.horizontalAlignment
//    property alias inputMethodHints:textedit.inputMethodHints

    property string wholeText

    property string __previousCharacter
    property string hideText


    function insertChar(character) {

        var text = textedit.text

        if(text.length > 12){
            textedit.font.pixelSize = 60;
        }else{
            textedit.font.pixelSize = 80;
        }

        textedit.text = text + character ;


    }

    function backspace() {


        var text = textedit.text

        textedit.text = text.slice(0,text.length-1) ;
    }



    function clear() {

        textedit.text = '';
    }



    Image {
        id: numberBack
        anchors {
            left:parent.left;right:parent.right
            verticalCenter:parent.verticalCenter

        }
        height:115
        source: "./image/number_back.png"
        transformOrigin: Item.Center



    }

    Image {
        id: adduser
        anchors {
            right:numberBack.right
            rightMargin:40

            verticalCenter:numberBack.verticalCenter
        }
        source: "./image/iconcontect.png"

    }



    Text {
        id:textedit

        clip:true

        elide:Text.ElideLeft
        anchors {
            left:parent.left
            right:adduser.left

            leftMargin:40;rightMargin:50
            verticalCenter:parent.verticalCenter

        }
        font.pixelSize: 70


        wrapMode:TextEdit.NoWrap

        onTextChanged:__resizeText();


        function __resizeText() {


        }

    }


    MouseArea {
        anchors.fill:textedit

        onPressed: {

            mouse.accepted = false;
        }
    }



}
