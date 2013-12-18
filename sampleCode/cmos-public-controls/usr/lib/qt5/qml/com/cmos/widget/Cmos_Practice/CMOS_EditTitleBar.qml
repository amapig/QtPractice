import QtQuick 2.0
import com.cmos.widget 1.0
CMOS_BasicTitleBar{
    UIConst{
        id: constUi
    }
    property int  factor: constUi.getValue("factor")

    implicitWidth: 720 * factor
    implicitHeight: 94 * factor

    leftText: "取消"
    leftIcon:""
    rightText: "取消全选"
    rightIcon:""

    leftBorderColor: "green"
    leftBorderWidth: 1
    rightBorderColor: "green"
    rightBorderWidth: 1

    titleFontSize: 36 * factor
    titleColor:"#787777"
    title:"新建联系人"

    lMargin:20
    rMargin:20
    spacing:20
    tMargin:10
    bMargin:10

}
