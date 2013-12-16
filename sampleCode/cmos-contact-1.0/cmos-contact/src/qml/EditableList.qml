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
    property variant originalDataType
    property bool bPhone: true;
    property int iSelectionDialogIndex: -1;

    model: ListModel {
    }
    property bool isSetup: false

    function setModelDataPhone(modelData, modelDataType) {
        isSetup = false
        bPhone = true
        model.clear()
        var modelDataTypeConvert = []

        for (var i = 0; i < modelData.length; ++i) {
            switch (modelDataType[i])
            {
                case 6:
                default:
                    modelDataTypeConvert.push(qsTr("Home"))
                    model.append({ data: modelData[i], data_type: qsTr("Home") })
                    break
                case 7:
                    modelDataTypeConvert.push(qsTr("Work"))
                    model.append({ data: modelData[i], data_type: qsTr("Work") })
                    break
                case 8:
                    modelDataTypeConvert.push(qsTr("Mobile"))
                    model.append({ data: modelData[i], data_type: qsTr("Mobile") })
                    break
                case 9:
                    modelDataTypeConvert.push(qsTr("Fax"))
                    model.append({ data: modelData[i], data_type: qsTr("Fax") })
                    break
                case 10:
                    modelDataTypeConvert.push(qsTr("Pager"))
                    model.append({ data: modelData[i], data_type: qsTr("Pager") })
                    break
            }
        }

        model.append({ data: "", data_type: qsTr("Home") })
        originalData = modelData
        originalDataType = modelDataTypeConvert
        isSetup = true
    }

    function setModelDataEmail(modelData, modelDataType) {
        isSetup = false
        bPhone = false
        model.clear()
        var modelDataTypeConvert = []

        for (var i = 0; i < modelData.length; ++i) {
            switch (modelDataType[i])
            {
                case 11:
                default:
                    modelDataTypeConvert.push(qsTr("Home"))
                    model.append({ data: modelData[i], data_type: qsTr("Home") })
                    break
                case 12:
                    modelDataTypeConvert.push(qsTr("Work"))
                    model.append({ data: modelData[i], data_type: qsTr("Work") })
                    break
                case 13:
                    modelDataTypeConvert.push(qsTr("Other"))
                    model.append({ data: modelData[i], data_type: qsTr("Other") })
                    break
            }
        }
        //console.log("model===",medeol)
        model.append({ data: "", data_type: qsTr("Home") })
        originalData = modelData
        originalDataType = modelDataTypeConvert
        isSetup = true
    }

    function setModelType(strModelType)
    {
        if (bPhone)
        {
            if (selectionPhoneDialog.selectedIndex != -1 &&
                iSelectionDialogIndex != -1)
            {
                model.get(iSelectionDialogIndex).data_type = strModelType
                iSelectionDialogIndex = -1
                isEdited()
            }
        }
        else
        {
            if (selectionEmailDialog.selectedIndex != -1 &&
                iSelectionDialogIndex != -1)
            {
                model.get(iSelectionDialogIndex).data_type = strModelType
                iSelectionDialogIndex = -1
                isEdited()
            }
        }
    }

    function isEdited()
    {
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

    function modelDataTypePhone() {
        var modelData = []

        // the -1 here is because we want to skip the always-added empty on the
        // end of the model.
        for (var i = 0; i < model.count - 1; ++i) {
            if (model.get(i).data_type == qsTr("Home"))
            {
                modelData.push(6)
            }
            else if (model.get(i).data_type == qsTr("Work"))
            {
                modelData.push(7)
            }
            else if (model.get(i).data_type == qsTr("Mobile"))
            {
                modelData.push(8)
            }
            else if (model.get(i).data_type == qsTr("Fax"))
            {
                modelData.push(9);
            }
            else
            {
                modelData.push(10)
            }
        }
        return modelData;
    }


    function modelDataTypeEmail() {
        var modelData = []

        // the -1 here is because we want to skip the always-added empty on the
        // end of the model.
        for (var i = 0; i < model.count - 1; ++i) {
            if (model.get(i).data_type == qsTr("Home"))
            {
                modelData.push(11)
            }
            else if (model.get(i).data_type == qsTr("Work"))
            {
                modelData.push(12)
            }
            else
            {
                modelData.push(13)
            }
        }
        return modelData;
    }

    delegate: Item {
        id: rootRow
        height: textField.height
        anchors.left: parent.left
        anchors.right: parent.right
        Rectangle {
            id: addressType
            width: 180
            height: parent.height
            color: "transparent"
            anchors.left: parent.left
            BorderImage {
                id: borderImage
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

                clip: true
                elide:Text.ElideRight
                text: model.data_type
                font.family: "Helvetica"
                font.pointSize: 26
                color: "#787777"
                font.bold: true
                //color: "black"
            }
            MouseArea{
                id: mouseArea
                width: 180
                height: parent.height
                anchors.left: parent.left
                hoverEnabled: true
                onReleased: {
                    borderImage.source = "../img/selectItem.png"
                    iSelectionDialogIndex = model.index
                    if (bPhone)
                    {
                        selectionPhoneDialog.visible = true
                        selectionPhoneDialog.selectedIndex = -1;
                        selectionPhoneDialog.open()
                    }
                    else
                    {
                        selectionEmailDialog.visible = true
                        selectionEmailDialog.selectedIndex = -1;
                        selectionEmailDialog.open()
                    }
                }
                onPressed : {
                    borderImage.source = "../img/selectItem_pressed.png"
                }
                onCanceled: {

                    borderImage.source = "../img/selectItem.png"
                }
            }
        }
       MyTextField {
            id: textField
            text: model.data
            placeholderText: root.placeholderText
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
                if (!root.isSetup)
                return

              root.model.get(index).data = text
              if (index == (root.model.count - 1)) {
                  root.model.append({ data: "", data_type: qsTr("Home") })
               } else if (text == "" && index != (root.model.count - 1)) {
                   root.model.remove(index)
               }
               isEdited()
              if ( text != "")
                  clearButton.visible = true;
              else
                  clearButton.visible = false;
            }
        }
        Button {
            id: clearButton
            iconSource: "../img/clear.png"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: 50
            visible: false
            onClicked: {
                textField.text = ""
            }
        }

        BorderImage {
                id:line
                source: "../img/line1px.png"
                width:parent.width
                height: 1
                anchors{
                    left:parent.left
                    bottom:parent.bottom
                }
            }

    }
}

