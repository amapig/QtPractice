import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
CMOS_BasicDialog {
    id:inputDialog
    property string title: "enter you want"
    property int titleFontSize: 36
    property color titleFontColor: "#000000"
    property string placeholderText :""

    property int editFontSize: 30
    property color editFontColor: "green"

    signal accepted(string value);
    signal rejected();
    signal finished();

    property Component textFieldStyleCmp:TextFieldStyle{
        id:textFieldStyle
        background: Item{
            implicitWidth: 560
            implicitHeight: inputDialog.editFontSize+8
        }
    }

    property int columnSpacing:36
    property int rowSpacing: 36

    property CMOS_Button cancleButton: null
    property CMOS_Button okButton: null
    property TextField txtField: null

    onCancel:
    {
        rejected();
        finished();
    }
    contentLabelCmp:Rectangle{
        height:column.height+60
        color:"white"
        radius: 2
        z:100
        Column{
            id:column
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:inputDialog.columnSpacing
            Label{
                anchors.horizontalCenter: parent.horizontalCenter
                text:inputDialog.title
                font.pixelSize: inputDialog.titleFontSize
                color:inputDialog.titleFontColor
            }
            Column{
                spacing:5
                width: parent.width
                TextField{
                    id:textField
                    anchors.left: line.left
                    anchors.right: line.right
                    font.pixelSize: inputDialog.editFontSize
                    text:""
                    style:inputDialog.textFieldStyleCmp
                    placeholderText: inputDialog.placeholderText
                    textColor:inputDialog.editFontColor
                    Component.onCompleted: inputDialog.txtField = textField
                }
                Rectangle{
                    id:line
                    width:parent.width-20
                    height:1
                    opacity: 0.73
                    color:"grey"
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: inputDialog.rowSpacing
                 CMOS_Button{
                     id:cancelBtn
                     text:"取消"
                     onClicked:{
                         inputDialog.rejected()
                         inputDialog.finished()
                         inputDialog.visible = false
                     }
                     Component.onCompleted: {
                        inputDialog.cancleButton   = cancelBtn
                     }
                 }
                 CMOS_Button{
                     id:okBtn
                     text:"确定"
                     onClicked:
                     {
                         inputDialog.accepted(textField.text)
                         inputDialog.finished()
                         inputDialog.visible = false
                     }
                     Component.onCompleted: {
                        inputDialog.okButton   = okBtn
                     }
                 }
            }
        }//~Column

    }//~label:Rectangle
}
