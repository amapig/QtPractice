import QtQuick 2.0

FocusScope {
    id: focusScope
    //width: 600; height: 40
    focus:true

    //    BorderImage {
    //        //source: "../images/lineedit-bg.png"
    //        width: parent.width; height: parent.height
    //        border { left: 4; top: 4; right: 4; bottom: 4 }
    //    }

    //    Text {
    //        id: typeSomething
    //        anchors.fill: parent
    //        anchors.leftMargin: 8
    //        verticalAlignment: Text.AlignVCenter
    //        text: "\u8BF7\u8F93\u5165\u7F51\u5740"
    //        color: "white"
    //    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            focusScope.focus = true
            textInput.openSoftwareInputPanel()
        }
    }

    TextInput {
        id: textInput
        color: "white"
        anchors { left: parent.left; leftMargin: 8; right: clear.left; rightMargin: 8; verticalCenter: parent.verticalCenter }
        focus: true
        font.pixelSize:20
    }

        Image {
            id: clear
            anchors { right: parent.right; rightMargin: 8; verticalCenter: parent.verticalCenter }
            //source: "../images/clear.png"
            opacity: 0

            MouseArea {
                anchors.fill: parent
                onClicked: { textInput.text = ''; focusScope.focus = true; textInput.openSoftwareInputPanel(); }
            }
        }

    states: State {
        name: "hasText"; when: textInput.text != ''
        PropertyChanges { target: typeSomething; opacity: 0 }
        PropertyChanges { target: clear; opacity: 1 }
    }

    transitions: [
        Transition {
            from: ""; to: "hasText"
            NumberAnimation { exclude: typeSomething; properties: "opacity" }
        },
        Transition {
            from: "hasText"; to: ""
            NumberAnimation { properties: "opacity" }
        }
    ]
}
