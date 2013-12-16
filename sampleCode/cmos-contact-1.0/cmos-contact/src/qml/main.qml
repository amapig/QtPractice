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

import org.nemomobile.contacts 1.0

PageStackWindow {
    id:app
    //id:main

    showToolBar:true
    showStatusBar:true


    PeopleModel {id:people}
    property PeopleModel favortesContactListModel: PeopleModel {
        // filterType:SeasideFilteredModel.FilterFavorites
        // for testing purposes
        Component.onCompleted: {
            //            importContacts("../test/example.vcf")
            setDisplayLabelOrder(1);
            setFilterType(2);//1

        }
    }
    property PeopleModel contactListModel: PeopleModel {

        Component.onCompleted: {
            setDisplayLabelOrder(1);
            setFilterType(1)
        }
    }

    //   initialPage:contact
    initialPage: {
   //     people
    //    contact
     //   pGroupPage
      //  favorites
        pDialPage

    }


    QueryDialog {
        id:dErrorDialog
        titleText:qsTr('Error')
        acceptButtonText:qsTr('OK')
        visible:false
    }
    Component.onCompleted: {
        theme.inverted = true
    }


    //HistoryPage {id:pHistoryPage;visible:false;tools:toolbar}
    //   FamiliarPage {id:pFamiliarPage;visible:false;}
    ContactListPage {id:contact;tools:toolbar}
    GroupPage {id:pGroupPage;visible:false;tools:toolbar}
    FavoritesListPage{id:favorites;tools:toolbar}
    DialPage {id:pDialPage;tools:toolbar}

    ToolBarLayout {
        id:toolbar
        height:108

        anchors{

            bottom:parent.bottom
            left:parent.left
            right:parent.right
            // bottomMargin:30
        }


        ButtonRow {

            PhoneTabButton {
                id: numberBtn
                height:110
                text: "拨号"
                onClicked:
                {
                    if(app.pageStack.currentPage !== pDialPage)
                    {
                        // app.pageStack.replace(pHistoryPage);
                        app.pageStack.replace(pDialPage);
                    }
                }
            }
            PhoneTabButton {
                id:contactBtn
                height:110
                text: "联系人"
                onClicked:
                {
                    if(app.pageStack.currentPage !==contact)
                    {
                        app.pageStack.replace(contact);
                    }
                }
            }
            PhoneTabButton {
                id:favoriteBtn
                height:110
                text: "常用"
                onClicked:
                {
                    if(app.pageStack.currentPage !==favorites)
                    {
                        app.pageStack.replace(favorites);
                    }

                }
            }
            PhoneTabButton {
                id:groupBtn
                text: "群组"
                height:110
                onClicked:
                {
                    if(app.pageStack.currentPage !== pGroupPage)
                    {
                        app.pageStack.replace(pGroupPage);
                    }
                }
            }
        }


    }

    function setToolBar(isShow)
    {
        toolbar.visible = isShow
    }

    function startAddContact(strPhoneNumber)
    {
        var editor = pageStack.openSheet(Qt.resolvedUrl("ContactEditorSheet.qml"));
        editor.contact = contactComponentCreate.createObject(editor)
        editor.setPhoneNumber(strPhoneNumber)
    }
    Component {
        id: contactComponentCreate
        Person {
        }
    }



    //initialPage: Component { ContactListPage {} }


    function addPhoneNumber(strPhoneNumber)
    {
        pDialPage.addPhoneNumber(strPhoneNumber)
    }

    //ContactsInterface { id: contactsInterface }
}
