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

Repeater {
    id: root

    property string placeholderText
    property bool edited : false
    property variant originalData
    property int iSelectionDialogIndex: 1;
    model: ListModel {
    }
    property bool isSetup: false




    Item {
    //property Item testItem: Item {
        id: rootItem
        anchors.left: parent.left
        anchors.right: parent.right
        height: 100
        width: 640
        anchors.leftMargin: 40
        anchors.rightMargin: 40
        property alias strAddressType: buttonLabel.text
        property alias selectModel: mySelect.model
        property QtObject myModel: addrModel
        property string buttonText

        Component.onCompleted: {
            console.log("model count ",root.model.count)
            for(var i=0; i<root.model.count;i++)
            {
                console.log("sel name ====",root.model.get(i).data_type)
            }
            setModel(root.model.get(root.model.count-1).data_type)
            buttonText =root.model.get(0).data_type
          //  strAddressType = selectModel.get(0).name
        }

        ListModel{
           id:addrModel
                   ListElement { name:"Home" }
                   ListElement { name:"Work" }
                   ListElement { name:"Other" }
       }
        ListModel{
            id: webModel
            ListElement{ name: "Website"}
        }
        ListModel{
            id: nickModel
            ListElement{ name: "Nickname"}
        }
        ListModel{
            id: birthModel
            ListElement{ name: "Birthday"}
       //     ListElement{ name: "Anniversary"}
        }
        ListModel{
            id:notesModel
            ListElement{ name: "Notes"}
        }

        function setModelType(strModelType)
        {
            console.log("strModelType==========",strModelType,mySelect.selectedIndex,iSelectionDialogIndex)
            if (mySelect.selectedIndex != -1 &&
                    iSelectionDialogIndex != -1)
            {
                root.model.get(iSelectionDialogIndex).data_type = strModelType
                console.log("strModelType===222=======",strModelType)
                buttonText = strModelType
              //  strAddressType =root.model.data_type
                iSelectionDialogIndex = -1
                isEdited()
            }
        }

        function isEdited()
        {
            console.log("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn")
            edited = false
            if (model.count - 1 != originalData.length)
            {
                edited = true
            }
            else
            {
                for (var i = 0; i < model.count - 1; ++i) {
                    if (model.get(i).data != originalData[i] ||
                        model.get(i).data_type != originalDataType[i])
                    {
                        edited = true
                    }
                }
            }
        }

        function modelData() {
            var modelData = []

            // the -1 here is because we want to skip the always-added empty on the
            // end of the model.
            for (var i = 0; i < model.count - 1; ++i) {
                modelData.push(model.get(i).data)
            }
            return modelData;
        }



        function setModel(nText)
        {
            selectModel.clear();
            console.log("nText======",nText)
            if(nText== qsTr("Address")||nText==qsTr("Home")||nText == qsTr("Work")||nText==qsTr("Other"))
            {
                selectModel=myModel
            }
            if(nText== qsTr("Nickname"))
            {
                selectModel=nickModel
            }
            if(nText== qsTr("Website"))
            {
                selectModel=webModel
            }
            if(nText== qsTr("Birthday"))
            {
                selectModel=birthModel
            }

            if(nText== qsTr("Notes"))
            {
                selectModel=notesModel
            }
        }





        MySelectionDialog {
            id: mySelect
            titleText: textField.placeholderText
            //titleText: root.model.data
            //titleText: qsTr("邮箱")
            selectedIndex: 1
            visible: false
            // ListModel {
           //     ListElement { name:"家用" }
            //    ListElement { name:"工作" }
             //   ListElement { name:"其他" }
            //}
             onSelectedIndexChanged: {
                if (selectedIndex != -1)
                {
                    setModelType(mySelect.model.get(selectedIndex).name)
                    console.log("index====",selectedIndex)
                    console.log("name==",mySelect.model.get(selectedIndex).name)
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
/*
        Label {
            id: addressType
            text: model.data
            //font.family: "Helvetica"
            font.pointSize: 30
            color: "#c2cccc"
            //color: "black"
        }

        TextField {
            id: data_street
            text: model.data_street
            placeholderText: qsTr("Street address")
            anchors { top: addressType.bottom;
            }
            onTextChanged: {
                root.model.get(index).data_street = text
                if (isSetup)
                {
                    isEdited()
                }
            }
        }


        */





        Rectangle {
            id: addressType
            width: 180
            height: parent.height
            color: "transparent"
            anchors.left: parent.left
            BorderImage {
                source: "../img/selectItem.png"
                width: addressType.width
                height: 100

            }

            Text{
                id: buttonLabel
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 60
                anchors.leftMargin: 10
                anchors.left: parent.left
                width: 110
                text: buttonText
                //text: model.data_type
                font.pointSize: 26
                clip: true
                elide:Text.ElideRight
                color: "#787777"
                font.bold: true
            }
            MouseArea{
                id: mouseArea
                width: 180
                height: parent.height
                anchors.left: parent.left

                onClicked: {
                    iSelectionDialogIndex = model.index
                    mySelect.visible = true
                    mySelect.selectedIndex = -1;
                    mySelect.open()
                }

            }
        }
       MyTextField {
            id: textField
            text:model.data
            placeholderText: (model.data_type==qsTr("Home")||model.data_type==qsTr("Work")||model.data_type==qsTr("Other"))? qsTr("Address"):model.data_type
            width:400
            height: 100
            clip: true
            anchors.left: addressType.right
            anchors.right:clearButton.left
            anchors.rightMargin: 30
            anchors.leftMargin: 30
            style: MyTextFieldStyle{
                textFont.bold: true
                textFont.pixelSize: 30
            }

            onTextChanged: {

                  console.log("index=",index);
                    console.log("text=",text);
                    console.log("count=",root.model.count);
              console.log("model=",root.model.get(index));
              console.log("issetup=",root.isSetup);
                if (!root.isSetup)
                return

              root.model.get(index).data = text
              if (index == (root.model.count - 1)) {
                 //  root.model.append({ data: "", data_type: "家用" })
               } else if (text == "" ) {
               //} else if (text == "" && index != (root.model.count - 1)) {
                   root.model.remove(index)

               }


               isEdited()
              if ( text != "" && text != model.data_type )
                  clearButton.visible = true;
              else
                  clearButton.visible = false;
            }
        }
        BorderImage{
            id: clearButton
            source: "../img/clear.png"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: 50
            visible: false
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    textField.text = ""
                }
            }
        }

        BorderImage {
                id:line
                source: "../img/line1px.png"
                width:parent.width
                height: 1
                anchors{
                    left:parent.left
                    bottom:textField.bottom
                }
            }






        /*
        TextField {
                id: data_city
                text: model.data_city
                placeholderText: qsTr("City")
                anchors { top: data_street.bottom;
                    topMargin:  data_street.topMargin;
                    right: data_street.right; left: data_street.left
            }
                onTextChanged: {
                    root.model.get(index).data_city = text
                    if (isSetup)
                    {
                        isEdited()
                    }
                }
        }

        TextField {
                id: data_state
                text: model.data_state
                placeholderText: qsTr("State")
                anchors { top: data_city.bottom;
                    topMargin:  data_street.topMargin;
                    right: data_street.right; left: data_street.left
            }
                onTextChanged: {
                    root.model.get(index).data_state = text
                    if (isSetup)
                    {
                        isEdited()
                    }
                }
        }

        TextField {
                id: data_postalcode
                text: model.data_postalcode
                placeholderText: qsTr("Postal code")
                anchors { top: data_state.bottom;
                    topMargin:  data_street.topMargin;
                    right: data_street.right; left: data_street.left
            }
                onTextChanged: {
                    root.model.get(index).data_postalcode = text
                    if (isSetup)
                    {
                        isEdited()
                    }
                }
        }

        TextField {
                id: data_country
                text: model.data_country
                placeholderText: qsTr("Country")
                anchors { top: data_postalcode.bottom;
                    topMargin:  data_street.topMargin;
                    right: data_street.right; left: data_street.left
            }
                onTextChanged: {
                    root.model.get(index).data_country = text
                    if (isSetup)
                    {
                        isEdited()
                    }
                }
        }

        TextField {
                id: data_postofficebox
                text: model.data_postofficebox
                placeholderText: qsTr("Post Office Box")
                anchors { top: data_country.bottom;
                    topMargin:  data_street.topMargin;
                    right: data_street.right; left: data_street.left
            }
                onTextChanged: {
                    root.model.get(index).data_postofficebox = text
                    if (isSetup)
                    {
                        isEdited()
                    }
                }
        }
        */
    }
    function addNewData(nText)
    {
        console.log("EditAddress.qml--443----",nText)
        model.append({ data:"",data_type: nText})
        edited = true
    }

    function isAddressTypeExists(nType)
    {
               for (var i=0;i<model.count;++i)
        {
            if (model.get(i).data_type == nType)
            {
                return true;
            }
        }

        return false;
    }


    function setModelData(modelDataType, modelData) {
        isSetup = false
        edited = false
        model.clear()

        console.log("EidtAddress.qml-----467---------",modelDataType,modelData)
        for (var i = 0; i < modelData.length; ++i) {
            var words = modelData[i].split("\n")
            switch (modelDataType[i])
            {
            case 14:

                model.append({ data: modelData, data_type: qsTr("Home")})

                break;
            case 15:
                model.append({ data: modelData,data_type: qsTr("Work")})
                break;
            case 16:
                model.append({ data: modelData,data_type: qsTr("Other")})
                break;
            case 23:
                model.append({ data: modelData[i],data_type: qsTr("Website")})
                break;
            case 26:
                model.append({ data: modelData,data_type: qsTr("Birthday")})
                break;
          //  case 27:
           //     model.append({ data: modelData[i],data_type: qsTr("Anniversary")})
            //    break;
            case 4:
                model.append({ data: modelData,data_type: qsTr("Nickname")})
                break;
            case 5:  //实际用的是TitleType因为没notes数据类型
                model.append({ data: modelData,data_type: qsTr("Notes")})
                break;
           default:
           //     model.append({ data_type: modelDataType[i]})
                break;
            }
        }
        console.log("EidtAddress.qml-----503---------",modelData)
        originalData = modelDataFull()
        console.log("EidtAddress.qml-----505---------",modelData)
        isSetup = true
    }


    function modelData() {
        var modelData = []

      //  console.log("EditAddress.qml-----=====aaaaaaaaaa",model.get(0).data)
        for (var i=0;i<model.count;++i) {
            if (model.get(i).data)
            {
                modelData.push(model.get(i).data);
                if(model.get(i).data_type == qsTr("Address")||model.get(i).data_type==qsTr("Home")||model.get(i).data_type==qsTr("Work")
                        ||model.get(i).data_type==qsTr("Other"))
                {
                    modelData.push("a\n")
                    modelData.push("a\n")
                    modelData.push("a\n")
                    modelData.push("a\n")
                    modelData.push("a\n")

                    console.log("EditAddress.qml-----524=====aaaaaaaaaa",model.get(i).data)
                }
                console.log("data=====",model.get(i).data)
            }
        }
        return modelData;
    }

    function modelDataFull() {
        var modelData = []

        for (var i=0;i<model.count;++i) {
            modelData.push(model.get(i).data);
        }
        return modelData;
    }


    function modelDataTypes() {
        var modelData = []

        for (var i=0;i<model.count;++i) {
            if (model.get(i).data)
            {
                if (model.get(i).data_type == qsTr("Home"))
                {
                    modelData.push(14)
                }
                if (model.get(i).data_type == qsTr("Work"))
                {
                    modelData.push(15)
                }
                if (model.get(i).data_type == qsTr("Other"))
                {
                    modelData.push(16)
                }
                if (model.get(i).data_type == qsTr("Website"))
                {
                    modelData.push(23)
                }
                if (model.get(i).data_type == qsTr("Birthday"))
                {
                    modelData.push(26)
                }
              //  if (model.get(i).data_type == qsTr("Anniversary"))
               // {
                //    modelData.push(27)
                //}
                if (model.get(i).data_type == qsTr("Nickname"))
                {
                    modelData.push(4)
                }
                if (model.get(i).data_type == qsTr("Notes"))
                {
                    modelData.push(5)
                }
            }
        }
        return modelData;
    }

    function isEdited()
    {
        edited = false;
        console.log("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
        var modelData = modelDataFull()
        edited = false

        if (originalData.length == modelData.length)
        {
            for (var i=0;i<originalData.length;++i) {
                if (modelData[i] != originalData[i])
                {
                    edited = true
                    return true
                }
            }
        }
        else
        {
            edited = true
        }

        return edited;
    }







}

