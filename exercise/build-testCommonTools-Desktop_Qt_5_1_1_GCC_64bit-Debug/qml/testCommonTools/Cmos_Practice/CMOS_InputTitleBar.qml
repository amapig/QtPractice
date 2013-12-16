import QtQuick 2.0

CMOS_BasicTitleBar{
    id:inputTitleBar
    signal textChanged()
    function getText()
    {
        if(middleArea)
        {
            return middleArea.getText()
        }
        return ""
    }
    implicitWidth: 720
    implicitHeight: 94
    lMargin: 20
    tMargin: 10
    bMargin: 14
    rMargin: 20
    spacing:20

    leftBorderWidth: 0
    rightBorderWidth: 0

    middleComponent: CMOS_LineEdit{
        lMargin: 14
        tMargin: 2
        bMargin: 2
        rMargin: 20
        spacing:20
        titleFontSize: 24
        enableRight: false
        onTextChanged: {
            inputTitleBar.textChanged()
        }
    }

    leftIcon: "images/backico.png"
    leftText:""
    rightIcon: "images/moreico.png"
    rightText:""
    onLTrigger: console.log("CMOS_InputTitleBar  onlTrigger")
    onRTrigger: console.log("CMOS_InputTitleBar  onrTrigger")

}
