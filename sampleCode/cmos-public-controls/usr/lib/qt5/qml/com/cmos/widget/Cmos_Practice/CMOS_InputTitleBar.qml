import QtQuick 2.0
import com.cmos.widget 1.0
CMOS_BasicTitleBar{
    id:inputTitleBar
    UIConst{
        id: constUi
    }
    property int  factor: constUi.getValue("factor")

    signal finished(string text)
    signal textChanged()
    property bool isEditing:false
    function getText()
    {
        if(middleArea)
        {
            return middleArea.getText()
        }
        return ""
    }
    implicitWidth: 720 * factor
    implicitHeight: 94 * factor
    lMargin: 20
    tMargin: 10
    bMargin: 14
    rMargin: 20
    spacing:20 * factor

    leftBorderWidth: 0
    rightBorderWidth: 0

    middleComponent: CMOS_LineEdit{
        lMargin: 14
        tMargin: 2
        bMargin: 2
        rMargin: 20
        spacing:20 * factor
        titleFontSize: 24 * factor
        enableRight: true
        onTextChanged: {
            inputTitleBar.textChanged()
        }
        onFinished: inputTitleBar.finished(text)
    }

    leftIcon: "images/backico.png"
    leftText:""
    rightIcon: "images/moreico.png"
    rightText:""
    onLTrigger: console.log("CMOS_InputTitleBar  onlTrigger")
    onRTrigger: console.log("CMOS_InputTitleBar  onrTrigger")

    Binding{
        target:  inputTitleBar
        property: "isEditing"
        value:middleArea.middleArea.focus
    }
}
