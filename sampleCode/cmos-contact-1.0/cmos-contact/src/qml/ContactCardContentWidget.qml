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
import org.nemomobile.contacts 1.0
import org.nemomobile.qmlcontacts 1.0
import org.nemomobile.voicecall 1.0

Flickable {
    id: detailViewPortrait
    contentWidth: parent.width
    contentHeight: childrenRect.height
    flickableDirection: Flickable.VerticalFlick
    clip: true
    signal back()
    signal edit()
    property Person contact
    property VoiceCallManager callManager
    
    //function newContact()
    //{
     //   addressRepeater.setModelData(contact.addressTypes, contact.addresses)
   // }


    Rectangle{
    //Item {
        id: header
        height: 164
       // color: "red"
        color: "white"
     //   anchors.left: parent.left
      //  anchors.right: parent.right
        //height: avatar.height + UiConstants.DefaultMargin
        width: parent.width
        property int shortSize: parent.parent.width > parent.parent.height ? parent.parent.height : parent.parent.width
        BorderImage {
            id: backButton
            source: "../img/back.png"
            anchors.left: parent.left
            anchors.leftMargin: 15
          //  anchors.topMargin: 57
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: 50
            MouseArea{
                anchors.fill:parent
                onPressed: {
                    parent.source = "../img/back_pre.png"
                }
                onReleased: {
                    parent.source = "../img/back.png"
                    detailViewPortrait.back()

                }
                onCanceled: {
                    parent.source = "../img/back.png"

                }
            }
        }

        MyContactAvatarImage {
            id: avatar
            contact: detailViewPage.contact
            anchors.left: backButton.right
            //anchors.top: parent.top
            //anchors.topMargin: 22
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            width: 120
            height: 120
        }

        Label {
            id: personNameLabel
            anchors.verticalCenter:parent.verticalCenter
            anchors.left: avatar.right
            anchors.leftMargin: 20
            font.pixelSize: 48
            font.bold: true
            width: 255
            clip: true
            elide: Text.ElideRight
            wrapMode: Text.NoWrap
            //anchors.leftMargin: UiConstants.DefaultMargin
            text: contact.displayLabel
            color: "black"
        }

        Label {
            id: companyLabel
            anchors.top: personNameLabel.bottom;
            //anchors.verticalCenter: avatar.verticalCenter
            anchors.left: avatar.right
            anchors.leftMargin: 20
            //anchors.leftMargin: UiConstants.DefaultMargin
            font.pixelSize: 24
            font.bold: true
            width: 255

            wrapMode: Text.NoWrap
            clip: true
            elide: Text.ElideRight
            text: contact.companyName
            color: "green"
        }
        BorderImage{
            id:addFavoritesButton
            source:contact.favorite?"../img/favorites.png": "../img/addfavorites.png"
          //  anchors.left: companyLabel.right
           // anchors.leftMargin: 20
            anchors.right: editButton.left
            anchors.rightMargin: 50
            anchors.verticalCenter: parent.verticalCenter
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    contact.favorite = !contact.favorite
                    app.favortesContactListModel.savePerson(contact)
                }
            }

        }
        BorderImage{
            id: editButton
            source: "../img/edit.png"
           // anchors.leftMargin: 50
            //anchors.left: addFavoritesButton.right
            anchors.right: parent.right
            anchors.rightMargin: 45
            anchors.verticalCenter: parent.verticalCenter
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    parent.source = "../img/edit_pre.png"
                }
                onReleased: {
                    detailViewPortrait.edit()
                    parent.source = "../img/edit.png"
                }
                onCanceled: {
                    parent.source = "../img/edit.png"
                }
            }
        }
        BorderImage {
            id:header_line
            source: "../img/line1px.png"
            //width: data_first.width
            height: 1
            anchors{
                left:header.left
                right: header.right
                bottom:header.bottom
            }
        }
    }
    Column{
        id: phonesms
        anchors.left: parent.left
        anchors.top:header.bottom
        Repeater{
            id: phoneNumLabel
            anchors.left: parent.left
            model: contact.phoneNumbers
            Item{
                id: phoneItem
                anchors.left: parent.left
                anchors.topMargin: 00
                height: 160
                width: parent.width -80
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                Text{
                    id:phoneNum
                    text:modelData
                    font.pixelSize: 40
                    font.bold: true
                    color: "#787777"
                    anchors.topMargin: 40
                    anchors.top: parent.top
                 //   anchors.verticalCenter: parent.verticalCenter
                }
                Text{
                    id:phoneType
                    text:"Other |  China"
                    font.pixelSize: 26
                    font.bold: true
                    color: "#000000"
                    anchors.top: phoneNum.bottom
                  //  anchors.bottomMargin:  40
                    //anchors.verticalCenter: parent.verticalCenter
                }
                BorderImage{
                    id:smsBtn
                    source: "../img/sms.png"
                    anchors.right:callBtn.left
                    anchors.rightMargin: 70
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea{
                        anchors.fill:parent
                        onPressed: {
                            parent.source = "../img/sms_pre.png"
                            console.log("nickname............................",contact.nickname)
                        }
                        onReleased: {
                            parent.source = "../img/sms.png"

                        }
                        onCanceled: {
                            parent.source = "../img/sms.png"

                        }
                    }
                }

                BorderImage{
                    id:callBtn
                    source: "../img/call.png"
                    anchors.right: parent.right
                    //anchors.left: smsBtn.right
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea{
                        anchors.fill:parent
                        onPressed: {
                            parent.source = "../img/call_pre.png"
                        }
                        onReleased: {
                            parent.source = "../img/call.png"

                        }
                        onCanceled: {
                            parent.source = "../img/call.png"

                        }
                    }

                }
                BorderImage {
                    id:item_line
                    source: "../img/line1px.png"
                    //width: data_first.width
                    height: 1
                    width: contentWidth
                    //width: parent.width
                    anchors{
                        left:parent.left
                        bottom:parent.top
                    }
                }
            }
        }

    }
    Column{
        id:emails
        anchors.left: parent.left
        anchors.top:phonesms.bottom

        Repeater{
            id: emailLabel
            anchors.left: parent.left
            model: contact.emailAddresses

            Item{
                id: emailItem
                anchors.left: parent.left
                anchors.topMargin: 00
                height: 165
                width: parent.width -80
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                BorderImage {
                    id: emailIcon
                    source: index==0?"../img/email.png":""
                    width: 50; height: 50
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                    anchors.topMargin: 40
                }
                Text{
                    id:email
                    text:modelData
                    font.pixelSize: 40
                    font.bold: true
                    color: "#787777"
                    anchors.topMargin: 40
                    anchors.left: emailIcon.right
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                }
                Text{
                    id:emailTitle
                    text:qsTr("Email")
                    font.pixelSize: 26
                    font.bold: true
                    color: "#000000"
                    anchors.top:email.bottom
                    anchors.left: emailIcon.right
                    anchors.leftMargin: 30
                  //  anchors.bottomMargin:  40
                    //anchors.verticalCenter: parent.verticalCenter
                }
               BorderImage {
                    id:line
                    source: "../img/line1px.png"
                    //width: data_first.width
                    height: 1
                    width: contentWidth
                    //width: parent.width
                    anchors{
                        bottom:parent.top
                        left: emailIcon.right
                        leftMargin: 30
                    }
                }
            }
        }

    }
    Column{
        id:websites
        anchors.left: parent.left
        anchors.top:emails.bottom

        Repeater{
            id: websiteLabel
            anchors.left: parent.left
            model: contact.websites

            Item{
                id: websiteItem
                anchors.left: parent.left
                anchors.topMargin: 00
                height: 165
                width: parent.width -80
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                BorderImage {
                    id: websiteIcon
                    source: index==0?"../img/web.png":""
                    width: 50; height: 50
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                    anchors.topMargin: 40
                }
                Text{
                    id:website
                    text:modelData
                    font.pixelSize: 40
                    font.bold: true
                    color: "#787777"
                    anchors.topMargin: 40
                    anchors.left: websiteIcon.right
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                }
                Text{
                    id:websiteTitle
                    text:qsTr("Website")
                    font.pixelSize: 26
                    font.bold: true
                    color: "#000000"
                    anchors.top:website.bottom
                    anchors.left: websiteIcon.right
                    anchors.leftMargin: 30
                  //  anchors.bottomMargin:  40
                    //anchors.verticalCenter: parent.verticalCenter
                }
               BorderImage {
                    id:webline
                    source: "../img/line1px.png"
                    //width: data_first.width
                    height: 1
                    //width: parent.width
                    width: contentWidth
                    anchors{
                        bottom:parent.top
                        left: websiteIcon.right
                        leftMargin: 30
                    }
                }
            }
        }

    }
    Column{
        id:addresses
        anchors.left: parent.left
        anchors.top:websites.bottom
        visible: contact.addresses[0].substr(0,contact.addresses[0].indexOf(','))==""? false:true
        height:  contact.addresses[0].substr(0,contact.addresses[0].indexOf(','))==""?0:childrenRect.height

        Repeater{
            id: addressLabel
            anchors.left: parent.left
            model: contact.addresses

            Item{
                id: addressItem
                anchors.left: parent.left
                anchors.topMargin: 00
                height: 165
                width: parent.width -80
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                BorderImage {
                    id: addressIcon
                    source: index==0?"../img/addr.png":""
                    width: 50; height: 50
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                    anchors.topMargin: 40
                }
                Text{
                    id:address
                    text:modelData.substr(0,modelData.indexOf(","))
                    font.pixelSize: 40
                    font.bold: true
                    color: "#787777"
                    anchors.topMargin: 40
                    anchors.left: addressIcon.right
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                }
                Text{
                    id:addressTitle
                    text:qsTr("Address")
                    font.pixelSize: 26
                    font.bold: true
                    color: "#000000"
                    anchors.top:address.bottom
                    anchors.left: addressIcon.right
                    anchors.leftMargin: 30
                  //  anchors.bottomMargin:  40
                    //anchors.verticalCenter: parent.verticalCenter
                }
               BorderImage {
                    id:addrline
                    source: "../img/line1px.png"
                    //width: data_first.width
                    height: 1
                    //width: parent.width
                    width: contentWidth
                    anchors{
                        bottom:parent.top
                        left: addressIcon.right
                        leftMargin: 30
                    }
                }
            }
        }

    }
    Column{
        id:nickname
        anchors.left: parent.left
        anchors.top:addresses.bottom

        Repeater{
            id: nicknameLabel
            anchors.left: parent.left
            model: contact.nickname=="" ? "":[contact.nickname]
            Item{
                id: nicknameItem
                anchors.left: parent.left
                anchors.topMargin: 00
                height: 165
                width: parent.width -80
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                BorderImage {
                    id: nicknameIcon
                    source: index==0?"../img/nickname.png":""
                    width: 50; height: 50
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                    anchors.topMargin: 40
                }
                Text{
                    id:nick
                    text:modelData
                    font.pixelSize: 40
                    font.bold: true
                    color: "#787777"
                    anchors.topMargin: 40
                    anchors.left: nicknameIcon.right
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                }
                Text{
                    id: nicknameTitle
                    text:qsTr("Nickname")
                    font.pixelSize: 26
                    font.bold: true
                    color: "#000000"
                    anchors.top:nick.bottom
                    anchors.left: nicknameIcon.right
                    anchors.leftMargin: 30
                  //  anchors.bottomMargin:  40
                    //anchors.verticalCenter: parent.verticalCenter
                }
               BorderImage {
                    id:nickline
                    source: "../img/line1px.png"
                    //width: data_first.width
                    height: 1
                    //width: parent.width
                    width: contentWidth
                    anchors{
                        bottom:parent.top
                        left: nicknameIcon.right
                        leftMargin: 30
                    }
                }
            }
        }

    }
    Column{
        id:birthday
        anchors.left: parent.left
        anchors.top:nickname.bottom

        Repeater{
            id: birthLabel
            anchors.left: parent.left
            model: Qt.formatDateTime(contact.birthday,"yyyy.MM.dd")==""? []:[Qt.formatDateTime(contact.birthday,"yyyy.MM.dd")]
            Item{
                id: birthItem
                anchors.left: parent.left
                anchors.topMargin: 00
                height: 165
                width: parent.width -80
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                BorderImage {
                    id: birthIcon
                    source: index==0?"../img/birthday.png":""
                    width: 50; height: 50
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                    anchors.topMargin: 40
                }
                Text{
                    id: birth
                    text:modelData
                    font.pixelSize: 40
                    font.bold: true
                    color: "#787777"
                    anchors.topMargin: 40
                    anchors.left: birthIcon.right
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                }
                Text{
                    id: birthTitle
                    text:qsTr("Birthday")
                    font.pixelSize: 26
                    font.bold: true
                    color: "#000000"
                    anchors.top:birth.bottom
                    anchors.left: birthIcon.right
                    anchors.leftMargin: 30
                  //  anchors.bottomMargin:  40
                    //anchors.verticalCenter: parent.verticalCenter
                }
               BorderImage {
                    id:birthline
                    source: "../img/line1px.png"
                    //width: data_first.width
                    height: 1
                    //width: parent.width
                    width: contentWidth
                    anchors{
                        bottom:parent.top
                        left: birthIcon.right
                        leftMargin: 30
                    }
                }
            }
        }

    }
    Column{
        id:notes
        anchors.left: parent.left
        anchors.top:birthday.bottom

        Repeater{
            id: noteLabel
            anchors.left: parent.left
            model: contact.title =="" ? "":[contact.title]
            Item{
                id: noteItem
                anchors.left: parent.left
                anchors.topMargin: 00
                height: 165
                width: parent.width -80
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                BorderImage {
                    id: noteIcon
                    source: index==0?"../img/notes.png":""
                    width: 50; height: 50
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                    anchors.topMargin: 40
                }
                Text{
                    id: note
                    text:modelData
                    font.pixelSize: 40
                    font.bold: true
                    color: "#787777"
                    anchors.topMargin: 40
                    anchors.left: noteIcon.right
                    anchors.leftMargin: 30
                    anchors.top: parent.top
                }
                Text{
                    id: noteTitle
                    text:qsTr("Notes")
                    font.pixelSize: 26
                    font.bold: true
                    color: "#000000"
                    anchors.top:note.bottom
                    anchors.left: noteIcon.right
                    anchors.leftMargin: 30
                  //  anchors.bottomMargin:  40
                    //anchors.verticalCenter: parent.verticalCenter
                }
               BorderImage {
                    id: noteline
                    source: "../img/line1px.png"
                    //width: data_first.width
                    height: 1
                    //width: parent.width
                    width: contentWidth
                    anchors{
                        bottom:parent.top
                        left: noteIcon.right
                        leftMargin: 30
                    }
                }
            }
        }

    }
    Rectangle{
        id: ringRect
     //   anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:notes.bottom
        anchors.left: parent.left
        anchors.topMargin: 60
        width: parent.width-80
        height: 100
        anchors.leftMargin: 40
        anchors.rightMargin  : 40
        color: "transparent"
        BorderImage{
            id: ringBtn
            source: "../img/add.png"
            anchors.fill: parent
            MouseArea{
                anchors.fill:parent
                onPressed: {
                    parent.source = "../img/add_pre.png"
                }
                onReleased: {
                    parent.source = "../img/add.png"

                }
                onCanceled: {
                    parent.source = "../img/add.png"

                }
            }
        }
        BorderImage{
            id:icon
            source: "../img/ring.png"
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
        }
        Text{
            id: ringName
            font.bold: true
            font.pixelSize: 30
            anchors.left:icon.right
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            clip: true
            elide: Text.ElideRight
            text: qsTr("Default ringtone")
        }

    }
    Rectangle{
        id: shareContact
     //   anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: ringRect.bottom
        anchors.left: parent.left
        anchors.topMargin: 26
        width: (parent.width-80-26)/2
        height: 100
        anchors.leftMargin: 40
       // anchors.rightMargin  : 40
        color: "transparent"
        BorderImage{
            id: sharebtn
            source: "../img/s_btn.png"
            anchors.fill: parent
            MouseArea{
                anchors.fill:parent
                onPressed: {
                    parent.source = "../img/s_btn_pre.png"
                }
                onReleased: {
                    parent.source = "../img/s_btn.png"

                }
                onCanceled: {
                    parent.source = "../img/s_btn.png"

                }
            }
        }
        BorderImage{
            id: shareicon
            source: "../img/share.png"
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
        }
        Text{
            id: shareTitle
            font.bold: true
            font.pixelSize: 30
            anchors.left:shareicon.right
            anchors.leftMargin: 30
            width: parent.width-130
            clip: true
            elide: Text.ElideRight
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Share contacts")
        }

    }
    Rectangle{
        id: addBlacklist
     //   anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: ringRect.bottom
        anchors.left: shareContact.right
        anchors.topMargin: 26
        width: (parent.width-80-26)/2
        height: 100
        anchors.leftMargin: 26
       // anchors.rightMargin  : 40
        color: "transparent"
        BorderImage{
            id: blackListbtn
            source: "../img/s_btn.png"
            anchors.fill: parent
            MouseArea{
                anchors.fill:parent
                onPressed: {
                    parent.source = "../img/s_btn_pre.png"
                }
                onReleased: {
                    parent.source = "../img/s_btn.png"

                }
                onCanceled: {
                    parent.source = "../img/s_btn.png"

                }
            }
        }
        BorderImage{
            id:blackListIcon
            source: "../img/blacklist.png"
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
        }
        Text{
            id:blackListTitle
            font.bold: true
            font.pixelSize: 30
            anchors.left:blackListIcon.right
            anchors.leftMargin: 30
            width: parent.width-130
            clip: true
            elide: Text.ElideRight
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Add blacklist")
        }

    }
    /*
    SelectionDialog {
        id: selectionDialog
        property int mode: 0 // 0: call, 1: sms, 2: message, 3: mail

        onSelectedIndexChanged: {
            if (mode == 0)
                callManager.dial(callManager.defaultProviderId, contact.phoneNumbers[selectedIndex]);
            else if (mode == 1)
                onClicked: messagesInterface.startSMS(contact.phoneNumbers[selectedIndex])
            else if (mode == 2)
                messagesInterface.startConversation(contact.accountPaths[selectedIndex], contact.accountUris[selectedIndex])
                
            accept()
        }
    }

    Button {
        id: callButton
        anchors.top: header.bottom
        anchors.topMargin: UiConstants.DefaultMargin
        anchors.left: parent.left
        anchors.leftMargin: UiConstants.DefaultMargin
        height: contact.phoneNumbers.length ? UiConstants.ListItemHeightDefault - UiConstants.DefaultMargin : 0
        width: parent.width - UiConstants.DefaultMargin * 2
        visible: height != 0
        iconSource: "image://theme/icon-m-telephony-incoming-call"; // TODO: icon-m-toolbar-make-call
        text: "Call"
        onClicked: {
            if (contact.phoneNumbers.length == 1) {
                callManager.dial(callManager.defaultProviderId, contact.phoneNumbers[0])
                return
            }

            selectionDialog.mode = 0
            selectionDialog.titleText = qsTr("Call %1").arg(contact.firstName)
            selectionDialog.model = contact.phoneNumbers
            selectionDialog.open()
        }
    }

    Button {
        id: smsButton
        anchors.top: callButton.bottom
        anchors.topMargin: UiConstants.DefaultMargin
        anchors.left: parent.left
        anchors.leftMargin: UiConstants.DefaultMargin
        height: contact.phoneNumbers.length ? UiConstants.ListItemHeightDefault - UiConstants.DefaultMargin : 0
        width: parent.width - UiConstants.DefaultMargin * 2
        visible: height != 0
        iconSource: "image://theme/icon-m-toolbar-send-chat";
        text: "SMS"
        onClicked: {
            if (contact.phoneNumbers.length == 1) {
                messagesInterface.startSMS(contact.phoneNumbers[0])
                return
            }

            selectionDialog.mode = 1
            selectionDialog.titleText = qsTr("SMS %1").arg(contact.firstName)
            selectionDialog.model = contact.phoneNumbers
            selectionDialog.open()
        }
    }

    Button {
        id: messageButton
        anchors.top: smsButton.bottom
        anchors.topMargin: UiConstants.DefaultMargin
        anchors.left: parent.left
        anchors.leftMargin: UiConstants.DefaultMargin
        height: contact.accountUris.length ? UiConstants.ListItemHeightDefault - UiConstants.DefaultMargin : 0
        width: parent.width - UiConstants.DefaultMargin * 2
        visible: height != 0
        iconSource: "image://theme/icon-m-toolbar-send-chat";
        text: "Message"
        onClicked: {
            if (contact.accountUris.length == 1) {
                messagesInterface.startConversation(contact.accountPaths[0], contact.accountUris[0])
                return
            }

            selectionDialog.mode = 2
            selectionDialog.titleText = qsTr("Message %1").arg(contact.firstName)
            selectionDialog.model = contact.accountUris
            selectionDialog.open()
        }
    }

    Button {
        id: mailButton
        anchors.top: messageButton.bottom
        anchors.topMargin: UiConstants.DefaultMargin
        anchors.left: parent.left
        anchors.leftMargin: UiConstants.DefaultMargin
        height: contact.emailAddresses.length ? UiConstants.ListItemHeightDefault - UiConstants.DefaultMargin : 0
        width: parent.width - UiConstants.DefaultMargin * 2
        visible: height != 0
        iconSource: "image://theme/icon-m-toolbar-send-sms"; // TODO: icon-m-toolbar-send-email
        text: "Mail"
        onClicked: {
            console.log("TODO: integrate with mail client")
            if (contact.emailAddresses.length == 1)
                return

            selectionDialog.mode = 3
            selectionDialog.titleText = qsTr("Mail %1").arg(contact.firstName)
            selectionDialog.model = contact.emailAddresses
            selectionDialog.open()
        }
    }
*/
    /*
    Column {
        anchors.top:addBlacklist.bottom
        anchors.topMargin: UiConstants.DefaultMargin
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: UiConstants.DefaultMargin
        anchors.leftMargin: 20

        ViewAddress {
            id: addressRepeater
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }    
    */


}

