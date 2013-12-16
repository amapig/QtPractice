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
import org.nemomobile.contacts 1.0
import org.nemomobile.commhistory 1.0
import com.nokia.meego 2.0

Item{
//Page {
    id:root

   // orientationLock:PageOrientation.LockPortrait
    property var mdate : new Date()

    Rectangle{
        color: "white"
        anchors.fill:root
    }
/*
    SelectionDialog {
        id:dHistorySelect
        model:ListModel {
            ListElement {tag:'recent'; name:'Recent calls'}
            ListElement {tag:'missed'; name:'Missed calls'}
            ListElement {tag:'incoming'; name:'Received calls'}
            ListElement {tag:'outgoing'; name:'Dialled calls'}
        }
        onSelectedIndexChanged: {
            var filter = model.get(selectedIndex);
            var filterRole = null;
            var filterString = null;

            switch(filter.tag) {
            case 'recent':
                filterRole = -1;
                filterString = "";
                break;

            case 'missed':
                filterRole = CommCallModel.IsMissedCallRole
                filterString = 'true'
                break;

            case 'incoming':
                filterRole = CommCallModel.DirectionRole
                filterString = '' + CommCallModel.Inbound
                break;

            case 'outgoing':
                filterRole = CommCallModel.DirectionRole
                filterString = '' + CommCallModel.Outbound
                break;
            }

            historyList.model.setFilterRole(filterRole)
            historyList.model.setFilterFixedString(filterString)
            bHistorySelect.text = filter.name
        }
    }

    PageHeader {
        id: bHistorySelect
        text: qsTr('Recent calls')
        color: "#228B22"

        MouseArea {
            anchors.fill: parent
            onClicked: dHistorySelect.open();
        }
    }
    */
    Component.onCompleted: {
          //  historyList.model.setFilterRole(-1)
    }
/*
    Button {
        id: clearBtn
        text: qsTr('Clear')
        anchors {top:bHistorySelect.bottom;margins:5;horizontalCenter:parent.horizontalCenter}
        onClicked: {
            console.log("clear btn");
            historyList.model.deleteAll();
        }
    }
    */
    ListView{
        id: gvp
        anchors {top:parent.top;bottom:parent.bottom;margins:5;horizontalCenter:parent.horizontalCenter}
        width: parent.width-10
        clip: true
        visible: false
        model: app.contactListModel
        delegate:MouseArea {
            id: listDelegate
            onClicked:
            {
                showphone()
                pageStack.push(Qt.resolvedUrl("ContactCardPage.qml"), { contact: model.person })
                app.setToolBar(false)
            }
            implicitHeight:model.person.phoneNumbers.length>1 ?nameFirst.implicitHeight+phonesms.implicitHeight+40: nameFirst.implicitHeight+88+onePN.height
            implicitWidth: parent.width
            property Person contact: model.person
            function showphone(){
                console.log("##################################model",model.person.phoneNumbers.length)
            }


            Label {
                id: nameFirst
                text: model.person.firstName
                elide: Text.ElideRight
                color: "#000000"
                font.pixelSize: 40
                font.bold: true
                height:  40
                clip:true
                anchors {
                    left:parent.left;
                    leftMargin: 40
                    topMargin:44
                    top:parent.top
                    right:parent.right
                    rightMargin: 100
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
                        }
                        Text{
                            id:phoneType
                            text:"Other |  China"
                            font.pixelSize: 26
                            font.bold: true
                            color: "#787777"
                            anchors.top: phoneNum.bottom
                            anchors.bottomMargin:  47
                        }
                        BorderImage {
                            id:item_line
                            source: "../img/line1px.png"
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
             Rectangle {
                width: parent.width
                height: 2
                color: "#787777"
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }

            states: State {
                name: "pressed"; when: pressed == true
                PropertyChanges { target: listDelegate; opacity: .7}
            }

        }


    }
    ListView {

        id:historyList
        anchors {top:parent.top;bottom:parent.bottom;margins:5;horizontalCenter:parent.horizontalCenter}
        width:parent.width - 10
        spacing:4
        clip:true
        model: CommCallModel {}

        onContentHeightChanged : {
            console.log("bbbbbbbbbbbbbbbbbbbbbbbbbbbb",historyList.contentHeight)
            if(historyList.contentHeight==52&&numberEntryText!="")
            {
                gvp.visible = true
            }
            else
            {
                gvp.visible = false
            }
        }


        delegate: Item {
            width:parent.width;height:visible?140:0
            property Person contact

            Component.onCompleted: {
                console.log(mdate.getFullYear()+"-"+(mdate.getMonth()+1)+"-"+mdate.getDate())
                console.log(Qt.formatDate(model.startTime,"yyyy-MM-dd"))
                contact =people.personByPhoneNumber(model.remoteUid);
                //contact = people.personByPhoneNumber(model.remoteUid);
                console.log(numberEntryText)
            }
            visible: numberEntryText==model.remoteUid.substr(0,numberEntryText.length)||numberEntryText==""


            Rectangle{
                anchors {left:parent.left; leftMargin:40; }//verticalCenter:parent.verticalCenter}
                height: parent.height
                //spacing:10

                Image {
                    id:callIcon
                    anchors.left:number.right
                    anchors.leftMargin: number.visible?24:0
                    anchors.bottom:  parent.bottom
                    anchors.bottomMargin:  38
                    smooth:true
                    // source: "../img/call.png"
                    source: "./image/" + (model.isMissedCall ? "missed" : (model.direction == CommCallModel.Inbound ? "in" : "out")) + "call.png"
                }

                Text {
                    id: disPlay
                    anchors.left:parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 35
                    color:model.isMissedCall ? '#ff3600' : 'black'
                    font.pixelSize:32
                    font.bold: true
                    text:contact ? contact.displayLabel : model.remoteUid
                }
                Text {
                    id:mytime
                    anchors.left:mydate.right
                    anchors.leftMargin: mydate.visible?12:0
                    anchors.bottom:  parent.bottom
                    anchors.bottomMargin:  35
                    color:'grey'
                    font.pixelSize:26
                    text:Qt.formatDateTime(model.startTime, "hh:mm")
                }
                Text {
                    id:mydate
                    anchors.left:callIcon.right
                    anchors.leftMargin: 10
                    anchors.bottom:  parent.bottom
                    anchors.bottomMargin:  35
                    color:'grey'
                    font.pixelSize:26
                    width: visible?children.width:0
                    visible: Qt.formatDate(model.startTime,"yyyy-MM-dd")==mdate.getFullYear()+"-"+(mdate.getMonth()+1)+"-"+mdate.getDate()?false:true
                    text:Qt.formatDateTime(model.startTime, "MM-dd")
                }
              //  Text {
                TextInput{
                    id: number
                    property variant selectText: numberEntryText
                    onSelectTextChanged:
                    {
                        console.log("onSelectTextChanged  :",selectText)
                        select(0,selectText.length)
                    }
                    anchors.left:parent.left
                    anchors.bottom:  parent.bottom
                    anchors.bottomMargin:  35
                    color:'grey'
                    font.pixelSize:26
                    width: visible?children.width:0
                    text:model.remoteUid
                    visible:  contact||numberEntryText!=""
                    focus: false
                    height: mydate.height
                    readOnly:true
                    enabled: false
                    selectedTextColor:  '#04b221'
                    selectionColor: "white"

                }
            }

          /*  Row {
                anchors {right:parent.right; rightMargin:10; verticalCenter:parent.verticalCenter}
                spacing:10
                
                BorderImage{
                //Button {
            //        text: qsTr('Add')
                  //  width: 80
                    visible: contact ? false : true
                    source: "../img/new.png"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            contactsInterface.startAddContact(model.remoteUid);
                        }
                    }
                }
                
                BorderImage{
                    width:72;height:60
                    source:'../img/call.png'
                    MouseArea{
                        anchors.fill: parent
                        onClicked:main.dial(model.remoteUid);
                    }
                }
            }
            */
            BorderImage {
                id:line
                source: "../img/line1px.png"
                width:parent.width
                height: 1
                anchors{
                    left:parent.left
                    bottom:parent.top
                }
            }
        }

        ViewPlaceholder {
            enabled: historyList.count == 0
            text: "No calls yet"
        }
    }
}

