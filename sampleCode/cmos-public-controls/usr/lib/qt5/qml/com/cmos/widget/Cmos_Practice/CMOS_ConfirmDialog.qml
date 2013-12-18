import QtQuick 2.0
import QtQuick.Controls 1.0
import com.cmos.widget 1.0

CMOS_BasicDialog{
    id:dialogItem
    UIConst{
        id: constUi
    }
    property real  factor: constUi.getValue("scale")
    property string title: "are you sure?"
    property int titleFontSize: 36 * factor
    property color titleFontColor: "#000000"

    property string info: ""
    property int infoFontSize: 40 * factor
    property color infoFontColor: "green"


    property int columnSpacing:36 * factor
    property int rowSpacing: 36 * factor

    signal accepted();
    signal rejected();
    signal finished();

    property CMOS_Button cancleButton: null
    property CMOS_Button okButton: null

    property Component infoItem:infoLoader.item
    property Component infoCmp:infoComponent

    Component{
        id:infoComponent
        Label{
            anchors.horizontalCenter: parent.horizontalCenter
            text:dialogItem.info
            font.pixelSize: dialogItem.infoFontSize
            color:dialogItem.infoFontColor
            wrapMode: Text.WordWrap
            height:contentHeight+16
        }
    }
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
            Loader{
                id:infoLoader
                sourceComponent: info!=""?infoCmp:null
                width: parent.width
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
