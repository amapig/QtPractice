import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import com.cmos.widget 1.0

CheckBox{
    id:checkBox
    UIConst{
        id: constUi
    }
    property int  factor: constUi.getValue("factor")

    property int fontSize:30 * factor
    property color fontColor:"green"

    property int spacing: 0
    property int lPadding:4
    property int rPadding:0
    property int tPadding:0
    property int bPadding:0
    property string source:"images/icontagon.png"//checked?"images/icontagon.png":"images/icontagoff.png"
    property int borderWidth:0
    property color borderColor:"grey"
    property color bgcolor: "white"

    property bool isSourceChanged: false
    onCheckedChanged: {
        isSourceChanged = false
    }
    onSourceChanged: {
        isSourceChanged = true
    }

    text:"checkBox"
    style:CheckBoxStyle {
        padding {
            top: control.tPadding
            left: control.lPadding
            right: control.rPadding
            bottom: control.bPadding
        }
        indicator: Rectangle{
            implicitWidth: checkImg.width
            implicitHeight: checkImg.height
            border.width:control.borderWidth
            border.color:control.borderColor
            color:control.bgcolor

            Image{
                id:checkImg
                visible:control.checked?true:control.isSourceChanged
                source:control.source
                fillMode: Image.PreserveAspectFit
            }
        }
        label:Label{
            font.pixelSize: control.fontSize
            color:control.fontColor
            text:control.text
            verticalAlignment: Qt.AlignVCenter
        }
        spacing:checkBox.spacing
    }
}
