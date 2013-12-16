import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
CMOS_BasicTitleBar{
    id:basicTitleBar

    property int editFontSize:30
    property color editTextColor:"green"
    property int editEchoMode:TextInput.Normal
    property string editPlaceHoldeText:""
    signal textChanged()
    function getText(){
        if(middleArea)
            return middleArea.text
    }
    enableLeft: true
    enableMiddle: true
    enableRight:true
    implicitWidth:640
    implicitHeight: 70

    lMargin:14
    rMargin:20
    tMargin:10
    bMargin:14
    spacing:20

    leftIcon:"images/search.png"
    leftText:""
    leftEnabled:false
    leftlMargin:4
    leftrMargin:6
    lefttMargin:4
    leftbMargin:4
    leftBorderWidth:0

    property Component textFieldStyle:textFieldStyleCmp
    Component{
        id:textFieldStyleCmp
        TextFieldStyle{
                id:textFieldStyle
                padding { top: 4 ; left: 4 ; right: 6 ; bottom:4 }
                background: Item{
                    implicitWidth: 100
                    implicitHeight: 30
                }
            }
    }

    middleComponent: TextField{
        implicitHeight: 70
        font.pixelSize: basicTitleBar.editFontSize
        placeholderText: basicTitleBar.editPlaceHoldeText
        echoMode:basicTitleBar.editEchoMode
        textColor:basicTitleBar.editTextColor
        style:textFieldStyle

        onTextChanged: {
            if(text != "")
            {
                if(basicTitleBar.rightButton)
                    basicTitleBar.rightButton.visible = true
            }
            else
            {
                if(basicTitleBar.rightButton)
                    basicTitleBar.rightButton.visible = false
            }
            basicTitleBar.textChanged()
        }
    }

    onRTrigger: {
        if(middleArea)
            middleArea.text = ""
    }

    rightIcon:"images/deleteico.png"
    rightText:""
    rightlMargin:0
    rightrMargin:0
    righttMargin:4
    rightbMargin:4

    Component.onCompleted: {
        if(rightButton)
            rightButton.visible = false
        if(middleArea)
            middleArea.text="just test for init in oncompleted signal"
    }
}
