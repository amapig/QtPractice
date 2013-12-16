/*
 * Copyright (C) 2012 Jolla Ltd.
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
import org.nemomobile.qmlcontacts 1.0
import org.nemomobile.contacts 1.0

MySheet {
    id: newContactViewPage
    /*
   acceptButtonText: qsTr("OK")
   //acceptButtonText: qsTr("确定")
   acceptButton.platformStyle: SheetButtonAccentStyle{
       background:"../img/accept_btn.png"
       pressedBackground: "../img/accept_btn.png"
       disabledBackground: "../img/accept_btn.png"
       buttonWidth: 140
       buttonHeight: 69
       fontPixelSize: 36
       textColor: "white"
   }

   rejectButtonText: qsTr("Cancel")

   //rejectButtonText: qsTr("取消")
   rejectButton.platformStyle: SheetButtonAccentStyle{
       background:"../img/cancel_btn.png"
       pressedBackground: "../img/cancel_btn.png"
       disabledBackground: "../img/cancel_btn.png"
       buttonWidth: 140
       buttonHeight: 69
       fontPixelSize: 36
       textColor: "#1ca72b"

   }
   */

    property bool bQuitAfterClosing: false
    signal deleteContact()

    acceptButtonEnabled: data_first.edited || //data_last.edited ||
                         data_company.edited ||
                         data_avatar.edited || phoneRepeater.edited ||
                         emailRepeater.edited || addressRepeater.edited||
                         nicknameRepeater.edited||websiteRepeater.edited||
                         birthRepeater.edited||noteRepeater.edited

    property Person contact
/*
   onAcceptButtonEnabledChanged: {
        console.log("acceptButtonEnabled",acceptButtonEnabled)
        console.log("a------------------\n")
        console.log(data_first.edited)
        console.log(data_company.edited)
        console.log(data_avatar.edited)
        console.log(phoneRepeater.edited)
        console.log(emailRepeater.edited)
        console.log(addressRepeater.edited)
        console.log(nicknameRepeater.edited)
        console.log(websiteRepeater.edited)
        console.log(birthRepeater.edited)
        console.log(noteRepeater.edited)
        console.log("a------------------\n")
        console.log("...",data_avatar.originalSource)
        console.log("...",data_avatar.source)
        console.log("...",contact.avatarPath)
        console.log(acceptButtonEnabled)
        console.log("a------------------\n")
    }

*/

    Connections {
        target: contact
        onContactRemoved: {
            reject()
        }
    }

    function setPhoneNumber(strPhoneNumber)
    {
        var modelData = []
        var modelDataType = []
        modelData.push(strPhoneNumber)
        modelDataType.push(14)
        phoneRepeater.setModelDataPhone(modelData, modelDataType)
        bQuitAfterClosing = true
    }


    onContactChanged: {
        data_first.text = contact.firstName
       // data_last.text = contact.lastName
        data_company.text = contact.companyName
        if(contact.avatarPath == "image://theme/icon-m-telephony-contact-avatar")
            contact.avatarPath = "../img/avatar.png"
        data_avatar.contact = contact
        if (contact.avatarPath != "../img/avatar.png" )
            data_avatar.originalSource =  contact.avatarPath
        else
            data_avatar.originalSource = "../img/avata.png"
        console.log("!!!",contact.avatarPath)
        console.log("!!!",data_avatar.source)
        console.log("!!!",data_avatar.originalSource)
        var type = []
        phoneRepeater.setModelDataPhone(contact.phoneNumbers, contact.phoneNumberTypes)
        emailRepeater.setModelDataEmail(contact.emailAddresses, contact.emailAddressTypes)
        if(contact.addresses[0])
        {
            addressRepeater.setModelData(contact.addressTypes, contact.addresses[0].substr(0,contact.addresses[0].indexOf(",")))
        }
        else
        {
            addressRepeater.setModelData(contact.addressTypes,"")
        }

        type[0]=4
        nicknameRepeater.setModelData(type,contact.nickname)
        websiteRepeater.setModelData(contact.websiteTypes,contact.websites)
        type[0]=26
        birthRepeater.setModelData(type,Qt.formatDateTime(contact.birthday,"yyyy.MM.dd"))
        type[0] =5
        noteRepeater.setModelData(type,contact.title)
    }

    MySelectionDialog {
        id: selectionDialog
        titleText: qsTr("Add another field")
        visible: false

        onSelectedIndexChanged: {
            /*
            if (selectedIndex != -1)
            {

                addressRepeater.addNewData(selectionDialog.model.get(selectedIndex).name);

            }
            */
            if (model.get(selectedIndex).name == qsTr("Address"))
            {
                addressRepeater.addNewData(qsTr("Home"));
                //addressRepeater.addNewData(selectionDialog.model.get(selectedIndex).name);
            }
            if (model.get(selectedIndex).name == qsTr("Nickname"))
            {
                nicknameRepeater.addNewData(selectionDialog.model.get(selectedIndex).name);
            }
            if (model.get(selectedIndex).name == qsTr("Website"))
            {
                websiteRepeater.addNewData(selectionDialog.model.get(selectedIndex).name);
            }
            if (model.get(selectedIndex).name == qsTr("Birthday"))
            {
                birthRepeater.addNewData(selectionDialog.model.get(selectedIndex).name);
            }
            if (model.get(selectedIndex).name == qsTr("Notes"))
            {
                noteRepeater.addNewData(selectionDialog.model.get(selectedIndex).name);
            }
        }
        onAccepted: {
            visible = false
        }
        onRejected: {
            visible = false
        }
    }

    MySelectionDialog {
        id: selectionPhoneDialog
        titleText: qsTr("Phone")

        selectedIndex: 1
        visible: false
        /*model: ListModel {
            ListElement { name:"家用" }
            ListElement { name:"工作" }
            ListElement { name:"移动" }
            ListElement { name:"传真" }
            ListElement { name:"寻呼机" }
        }*/
        model: ListModel {
            ListElement { name:"Home" }
            ListElement { name:"Work" }
            ListElement { name:"Mobile" }
            ListElement { name:"Fax" }
            ListElement { name:"Pager" }
        }

        onSelectedIndexChanged: {
            if (selectedIndex != -1)
            {
                phoneRepeater.setModelType(selectionPhoneDialog.model.get(selectedIndex).name)
                selectedIndex = -1
            }
        }
        onAccepted: {
            visible = false
        }
        onRejected: {
            visible = false
        }
    }

    MySelectionDialog {
        id: selectionEmailDialog
        titleText: qsTr("Email")
        //titleText: qsTr("邮箱")
        selectedIndex: 1
        visible: false
        /*
        model: ListModel {
            ListElement { name:"家用" }
            ListElement { name:"工作" }
            ListElement { name:"其他" }
        }
        */
        model: ListModel {
            ListElement { name:"Home" }
            ListElement { name:"Work" }
            ListElement { name:"Other" }
        }


        onSelectedIndexChanged: {
            if (selectedIndex != -1)
            {
                emailRepeater.setModelType(selectionEmailDialog.model.get(selectedIndex).name)
                console.log("index====",selectedIndex)
                console.log("name==",selectionEmailDialog.model.get(selectedIndex).name)
                selectedIndex = -1
            }
        }

        onAccepted: {
            visible = false
        }
        onRejected: {
            visible = false
        }
    }



    content: Flickable {
        anchors.fill: parent
        contentHeight: editorContent.childrenRect.height + UiConstants.DefaultMargin * 2
        id: contectFlick

        Item {
            id: editorContent
            //   anchors.leftMargin: UiConstants.DefaultMargin
            //  anchors.rightMargin: UiConstants.DefaultMargin
            anchors.fill: parent
            Rectangle{
                id: avatarRect
                height:180
                width:180
                radius: 90
                anchors { top: parent.top; topMargin: 47; left:parent.left; bottom:data_company.bottom
                    leftMargin: 40
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        var avatarPicker = pageStack.openSheet(Qt.resolvedUrl("AvatarPickerSheet.qml"), { contact: contact })
                        avatarPicker.avatarPicked.disconnect()
                        avatarPicker.avatarPicked.connect(function(avatar) {
                            data_avatar.source = avatar
                        });
                    }

                }

                MyContactAvatarImage {
                    id: data_avatar
                    property string originalSource
                    property bool edited: source !=originalSource
                    anchors.centerIn: parent
                    //       anchors.fill: parent
                    contact: newContactViewPage.contact

                }
            }
            MyTextField {
                id: data_first
                placeholderText: qsTr("Name")
                //placeholderText: qsTr("姓名")
                height: 100
                clip: true
                style: MyTextFieldStyle{
                    textFont.bold: true
                    textFont.pixelSize: 30
                }

                property bool edited: data_first.text != contact.firstName
                anchors { top: avatarRect.top; right: parent.right; left: avatarRect.right; leftMargin: 30; rightMargin: 40}

            }

            BorderImage {
                id:data_first_line
                source: "../img/line1px.png"
                width: data_first.width
                height: 1
                anchors{
                    left: data_first.left
                    bottom:data_first.bottom
                }
            }
            MyTextField {
                id: data_company
                placeholderText: qsTr("Company")
                //placeholderText: qsTr("公司")
                height: 100
                clip: true
                style: MyTextFieldStyle{
                    textFont.bold: true
                    textFont.pixelSize: 30
                }

                property bool edited: text != contact.companyName
                anchors { top: data_first.bottom;
                    //topMargin: UiConstants.DefaultMargin;
                    right: parent.right; left: data_first.left
                    //leftMargin: 30
                    rightMargin: 40
                }
            }
            BorderImage {
                id: data_company_line
                source: "../img/line1px.png"
                width: data_company.width
                height: 1
                anchors{
                    left:data_company.left
                    bottom:data_company.bottom
                }
            }
            Column {
                id: phones
                anchors.top: data_company.bottom
                anchors.topMargin: 60
                //anchors.topMargin: UiConstants.DefaultMargin
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                // width:  640
                //height: 100
                width:  100

                EditableList {
                    id: phoneRepeater
                    placeholderText: qsTr("Phone")
                    //placeholderText: qsTr("电话")
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
            BorderImage {
                id:phones_line
                source: "../img/line1px.png"
                width:phones.width
                height: 1
                anchors{
                    left:phones.left
                    bottom:phones.bottom
                }
            }
            Column {
                id: emails
                anchors.top: phones.bottom
                anchors.topMargin: 60
                anchors.left: parent.left
                //width:  640
                // height: 100
                width:  100
                anchors.right: parent.right
                anchors.leftMargin: 40
                anchors.rightMargin: 40

                EditableList {
                    id: emailRepeater
                    placeholderText: qsTr("Email")
                    //placeholderText: qsTr("邮箱")
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
            Rectangle{
                id: ring
                anchors.top:emails.bottom
                anchors.topMargin: 60
                anchors.left: parent.left
                anchors.leftMargin: 40
                anchors.rightMargin: 40
                anchors.bottomMargin: 60
                //  width:  640
                height: 100
                anchors.right: parent.right

                BorderImage {
                    id:buttonBorder
                    source:"../img/selectItem.png"
                    width: 180; height: 100
                    anchors.left: parent.left
                    Text{
                        text: qsTr("Ringtone")
                        //text: qsTr("铃声")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 60
                        anchors.leftMargin: 10
                        anchors.left: parent.left
                        width: 110
                        font.pointSize: 26
                        clip: true
                        elide:Text.ElideRight
                        color: "#787777"
                        font.bold: true

                    }

                }
                MouseArea{
                    anchors.fill: parent
                    onReleased: {
                        buttonBorder.source = "../img/selectItem.png"
                    }
                    onPressed : {
                        buttonBorder.source = "../img/selectItem_pressed.png"
                    }
                    onCanceled: {

                        buttonBorder.source = "../img/selectItem.png"
                    }
                }
                Text{
                    id: ringName
                    text:qsTr("Default ringtone")
                    //text:qsTr("默认铃声")
                    font.pixelSize: 30
                    color: "#000000"
                    clip: true
                    font.bold: true
                    anchors.left:buttonBorder.right
                    anchors.right: parent.right
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30
                    anchors.verticalCenter: parent.verticalCenter
                }


            }


            BorderImage {
                id:ring_line
                source: "../img/line1px.png"
                width:ring.width
                height: 1
                anchors{
                    left:ring.left
                    bottom:ring.bottom
                }
            }
            Button {
                id: buttonAddAddress
                anchors.top:note.bottom
                anchors.topMargin: 70
                //anchors.topMargin: UiConstants.DefaultMargin
                anchors.horizontalCenter: parent.horizontalCenter
                height: 100
                width: parent.width-80
                visible: true
                BorderImage {
                    id: border
                    source: "../img/add.png"
                    width:parent.width; height: parent.height
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5
                    MouseArea{
                        anchors.fill:parent
                        onPressed: {
                            parent.source = "../img/add_pre.png"
                        }
                        onReleased: {
                            parent.source = "../img/add.png"
                            buttonAddAddress.clicked()

                        }
                        onCanceled: {
                            parent.source = "../img/add.png"

                        }
                    }
                }
                Label {
                    id : addlabel
                    text: qsTr("Add another field")
                    //text: qsTr("添加更多项")
                    color: "#1ca72b"
                    font.pixelSize: 30
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                onClicked: {
                    selectionDialog.model.clear();
                    var iCount = 0;

                    if (!(addressRepeater.isAddressTypeExists(qsTr("Address"))||addressRepeater.isAddressTypeExists(qsTr("Home"))||
                          addressRepeater.isAddressTypeExists(qsTr("Work"))||addressRepeater.isAddressTypeExists(qsTr("Other"))))
                    {
                        selectionDialog.model.append( { name: qsTr("Address") } );
                        iCount = 1;
                    }
                    if (!nicknameRepeater.isAddressTypeExists(qsTr("Nickname")))
                    {
                        selectionDialog.model.append( { name: qsTr("Nickname") } );
                        iCount = 1;
                    }
                    if (!websiteRepeater.isAddressTypeExists(qsTr("Website")))
                    {
                        selectionDialog.model.append( { name: qsTr("Website") } );
                        iCount = 1;
                    }
                    if (!birthRepeater.isAddressTypeExists(qsTr("Birthday")))
                    {
                        selectionDialog.model.append( { name: qsTr("Birthday") } );
                        iCount = 1;
                    }
                    if (!noteRepeater.isAddressTypeExists(qsTr("Notes")))
                    {
                        selectionDialog.model.append( { name: qsTr("Notes") } );
                        iCount = 1;
                    }
                    if (iCount != 0)
                    {
                        selectionDialog.selectedIndex = -1;
                        selectionDialog.visible = true
                        //  address.anchors.topMargin = 60
                        selectionDialog.open()
                        console.log(selectionDialog.model)
                    }
                }
            }
            BorderImage {
                id: deleteContact
                source: "../img/delete.png"
                width:parent.width-80;
                height: 100
                border.left: 5; border.top: 5
                border.right: 5; border.bottom: 5
                anchors.left: parent.left
                anchors.leftMargin: 40
                anchors.top: buttonAddAddress.bottom
                anchors.topMargin: 30
                visible: contact.id? true:false
                Text{
                    id :delText
                    text: qsTr("Delete Contact")
                    color: "white"
                    font.pixelSize: 30
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill:parent
                    onPressed: {
                        parent.source = "../img/delete_pre.png"

                    }
                    onReleased: {
                        parent.source = "../img/delete.png"
                        newContactViewPage.deleteContact()
                        console.log("testContactEditorShee1111111111t@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")

                    }
                    onCanceled: {
                        parent.source = "../img/delete.png"

                    }
                }
            }
            Column {
                id: address
                anchors.top:ring.bottom
                anchors.topMargin:addressRepeater.model.count==0? 0: 60
                anchors.left: parent.left
                anchors.right: parent.right
                //spacing: UiConstants.DefaultMargin
                spacing: 60

                EditAddress {
                    id: addressRepeater
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
            Column {
                id:website
                anchors.top:address.bottom
                anchors.topMargin:websiteRepeater.model.count==0? 0: 60
                anchors.left: parent.left
                anchors.right: parent.right
                //spacing: UiConstants.DefaultMargin
                spacing: 60

                EditAddress {
                    id: websiteRepeater
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
            Column {
                id:nickName
                anchors.top:website.bottom
                anchors.topMargin:nicknameRepeater.model.count==0? 0: 60
                anchors.left: parent.left
                anchors.right: parent.right
                //spacing: UiConstants.DefaultMargin
                spacing: 60

                EditAddress {
                    id: nicknameRepeater
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
            Column {
                id:birth
                anchors.top:nickName.bottom
                anchors.topMargin:birthRepeater.model.count==0? 0: 60
                anchors.left: parent.left
                anchors.right: parent.right
                //spacing: UiConstants.DefaultMargin
                spacing: 60

                EditAddress {
                    id: birthRepeater
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
            Column {
                id:note
                anchors.top:birth.bottom
                anchors.topMargin:noteRepeater.model.count==0? 0: 60
                anchors.left: parent.left
                anchors.right: parent.right
                //spacing: UiConstants.DefaultMargin
                spacing: 60

                EditAddress {
                    id: noteRepeater
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }




        }
    }

    onRejected: {
            if(contact.id == 0)
                app.setToolBar(true)
        if (bQuitAfterClosing)
        {
            Qt.quit();
        }
    }
    onAccepted:{
        if(contact.id == 0)
            app.setToolBar(true)
        saveContact();

    }

    function saveContact() {
        contact.firstName = data_first.text
      //  contact.lastName = data_last.text
        contact.companyName = data_company.text
        contact.avatarPath = data_avatar.source
        contact.phoneNumbers = phoneRepeater.modelData()
        contact.phoneNumberTypes = phoneRepeater.modelDataTypePhone()
        contact.emailAddresses = emailRepeater.modelData()
        contact.emailAddressTypes = emailRepeater.modelDataTypeEmail()
        if(addressRepeater.modelData().length>0)
        {
            console.log("address==1==========",addressRepeater.modelData())
            contact.addresses[0]= addressRepeater.modelData()
            contact.addressTypes = addressRepeater.modelDataTypes()
        }
        else
        {
            console.log("address==0==========",addressRepeater.modelData())
            //contact.addresses[0]=undefined
            contact.addresses[0]=["",'a\n','a\n','a\n','a\n','a\n']
        }
        console.log("address============",addressRepeater.modelData())
        contact.websites = websiteRepeater.modelData()
        //contact.websiteTypes = websiteRepeater.modelDataTypes()
        if(nicknameRepeater.modelData().length>0)
        {
            console.log("nickname=1===========",nicknameRepeater.modelData()[0])
            contact.nickname = nicknameRepeater.modelData()[0]
        }
       else
        {
            contact.nickname = ""
            console.log("nickname=0===========",nicknameRepeater.modelData()[0])
        }
      //  contact.NickType = nicknameRepeater.modelDataTypes()
        if(birthRepeater.modelData().length>0)
            contact.birthday = birthRepeater.modelData()[0]
        else
            contact.birthday = undefined
       // contact.BirthdayType = birthRepeater.modelDataTypes()
      //  contact.anniversary = birthRepeater.modelData()
        if(contact.firstName==="")
        {
            contact.firstName = contact.displayLabel
        }

        if(noteRepeater.modelData().length>0)
        {
            contact.title = noteRepeater.modelData()[0]
        }
        else
            contact.title =""

        // TODO: this isn't asynchronous
        app.contactListModel.savePerson(contact)

        // TODO: revisit
        if (contact.dirty)
        {
            console.log("[saveContact] Unable to create new contact due to missing info");
        }
        else
        {
            console.log("[saveContact] Saved contact")
            if (bQuitAfterClosing)
            {
                Qt.quit();
            }
            else
            {
                app.pageStack.currentPage.contactChange();
            }
        }
    }
}


