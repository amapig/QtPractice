/*!
 * Author: Mengcong
 * Date: 2013.11.18
 * Details: Text button tool.
 */

import QtQuick 2.0

FocusScope {
    id: focusScope

    property string searchStr;
    function getSearchStr() {
        return textInput.getText(0, 50)
    }

    width: 450;
    height: 40
    focus: false

    Text {
        id: typeSomething
        anchors.fill: parent; anchors.leftMargin: 8
        verticalAlignment: Text.AlignVCenter
        text: searchStr
        font.pixelSize: 35
        font.italic: true
        color: "gray"
    }

//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//            focusScope.focus = true;
//            // textInput.openSoftwareInputPanel();
//            focusScope.searchStr = textInput.getText()
//            console.log("Input :" + focusScope.searchStr);
//        }
//    }

    TextInput {
        id: textInput
        width: parent.width - 40
        anchors { left: parent.left; leftMargin: 8; verticalCenter: parent.verticalCenter }
        focus: true
        font.pixelSize:20
    }

//    states: State {
//        name: "hasText"; when: textInput.text != ''
//        PropertyChanges { target: typeSomething; opacity: 0 }
//        PropertyChanges { target: clear; opacity: 1 }
//    }

//    transitions: [
//        Transition {
//            from: ""; to: "hasText"
//            NumberAnimation { exclude: typeSomething; properties: "opacity" }
//        },
//        Transition {
//            from: "hasText"; to: ""
//            NumberAnimation { properties: "opacity" }
//        }
//    ]
}
