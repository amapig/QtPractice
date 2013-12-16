/*
 * Copyright (C) 2011-2012 Robin Burchell <robin+mer@viroteck.net>
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * "Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *   * Neither the name of Nemo Mobile nor the names of its contributors
 *     may be used to endorse or promote products derived from this
 *     software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 */

import QtQuick 2.0
import com.nokia.meego 2.0
//import org.nemomobile.qmlcontacts 1.0
import org.nemomobile.contacts 1.0

MouseArea {
    id: listDelegate

    implicitHeight:model.person.phoneNumbers.length>1 ?nameFirst.implicitHeight+phonesms.implicitHeight+40: nameFirst.implicitHeight+88+onePN.height
    //height: UiConstants.ListItemHeightDefault
    implicitWidth: parent.width
    property Person contact: model.person
    function showphone(){
        console.log("##################################model",model.person.phoneNumbers.length)
    }

    /*ContactAvatarImage {
        id: photo
        contact: model.person
        x: UiConstants.DefaultMargin
        anchors.verticalCenter: parent.verticalCenter
    }
    */

    Label {
        id: nameFirst
        text: contact.displayLabel
        elide: Text.ElideRight
        color: "#000000"
        font.pixelSize: 40
        font.bold: true
        height:  45
        clip:true
        anchors {
            left:parent.left;
            leftMargin: 40
            topMargin:44
            top:parent.top
            right:parent.right
            rightMargin: 100
            //left: photo.right;
            //right: favorite.visible ? favorite.left : parent.right
            //verticalCenter: parent.verticalCenter;
        }
    }
    Text{
        id:onePN
        text:model.person.phoneNumbers.length==1 ?model.person.phoneNumbers[0]:""
        font.pixelSize: 26
        font.bold: true
        color: "#787777"
        height: model.person.phoneNumbers.length==1 ?30:0
        visible:model.person.phoneNumbers.length==1?true:false
        anchors.top: nameFirst.bottom
        anchors.bottomMargin: 44
        anchors.left: parent.left
        anchors.leftMargin: 40
    }
    Column{
        id: phonesms
        anchors.left: parent.left
        anchors.top:nameFirst.bottom
        visible:model.person.phoneNumbers.length>1?true:false
        Repeater{
            id: phoneNumLabel
            anchors.left: parent.left
            model:contact.phoneNumbers
            Item{
                id: phoneItem
                anchors.left: parent.left
                height: 160
                //width: parent.width
                width: parent.width-80
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                Text{
                    id:phoneNum
                    text:modelData
                    font.pixelSize: 26
                    font.bold: true
                    color: "#787777"
                    anchors.top: parent.top
                    anchors.topMargin: 47
                    //anchors.verticalCenter: parent.verticalCenter
                }
                Text{
                    id:phoneType
                    text:"Other |  China"
                    font.pixelSize: 26
                    font.bold: true
                    color: "#787777"
                    anchors.top: phoneNum.bottom
                    anchors.bottomMargin:  47
                    //anchors.verticalCenter: parent.verticalCenter
                }
                BorderImage {
                    id:item_line
                    source: "../img/line1px.png"
                    //width: data_first.width
                    height: 1
                    width: parent.width
                    anchors{
                        left:parent.left
                        bottom:parent.bottom
                    }
                }
            }
        }

    }

    // TODO: only instantiate if required?
    Image {
        id: favorite
        source: "../img/mark.png"
        visible: model.person.favorite
        anchors.right: parent.right
        anchors.rightMargin: 80
        //anchors.rightMargin: UiConstants.DefaultMargin
        anchors.verticalCenter: parent.verticalCenter
    }
    
    Rectangle {
        width: parent.width
        height: 2
        color: "#787777"
        anchors.right: parent.right
      //  anchors.rightMargin: UiConstants.DefaultMargin
        anchors.bottom: parent.bottom
    }

    states: State {
        name: "pressed"; when: pressed == true
        PropertyChanges { target: listDelegate; opacity: .7}
    }

}

