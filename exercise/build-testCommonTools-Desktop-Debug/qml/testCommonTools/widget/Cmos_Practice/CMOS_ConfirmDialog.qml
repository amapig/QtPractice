import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0


CMOS_BasicDialog{
    id:dialogItem
    property string title: "are you sure?"
    property int titleFontSize: 36
    property color titleFontColor: "#000000"

    property int columnSpacing:36
    property int rowSpacing: 36

    signal accepted();
    signal rejected();
    signal finished();

    property CMOS_Button cancleButton: null
    property CMOS_Button okButton: null

    onCancel:
    {
        rejected();
        finished();
    }
    contentLabelCmp:Rectangle{

        height:column.height+60
        color:"white"
        radius: 2
        Column{
            id:column
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:dialogItem.columnSpacing
            Label{
                anchors.horizontalCenter: parent.horizontalCenter
                text:dialogItem.title
                font.pixelSize: dialogItem.titleFontSize
                color:dialogItem.titleFontColor

            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: dialogItem.rowSpacing
                 CMOS_Button{
                     id:cancelBtn
                     text:"取消"
                     onClicked:{
                         dialogItem.rejected()
                         dialogItem.finished()
                         dialogItem.visible = false
                     }
                     Component.onCompleted: dialogItem.cancleButton = cancelBtn
                 }
                 CMOS_Button{
                     id:okBtn
                     text:"确定"
                     onClicked:
                     {
                         dialogItem.accepted()
                         dialogItem.finished()
                         dialogItem.visible = false
                     }
                     Component.onCompleted: dialogItem.okButton = okBtn
                 }
            }
        }

    }
}
