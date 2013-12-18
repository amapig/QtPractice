import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import com.cmos.widget 1.0
CMOS_BasicTitleBar{
    id:basicTitleBar
    UIConst{
        id: constUi
    }
    property int  factor: constUi.getValue("factor")

    property int editFontSize:30 * factor
    property color editTextColor:"green"
    property int editEchoMode:TextInput.Normal
    property string editPlaceHoldeText:""
    signal textChanged()
    function getText(){
        if(middleArea)
            return middleArea.text
    }
    signal finished(string text)

    enableLeft: true
    enableMiddle: true
    enableRight:true
    implicitWidth:640 * factor
    implicitHeight: 70 * factor

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
    property string prevText:""
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

        Keys.onEnterPressed:
        {
            focus = false
            basicTitleBar.finished(text)
        }
        Keys.onReturnPressed:
        {
            focus = false
            basicTitleBar.finished(text)
        }

        onFocusChanged: {
            if(focus)
                basicTitleBar.prevText = text
        }

    }

    onRTrigger: {
        if(middleArea)
            middleArea.text = ""
    }

    onLTrigger: {
       endEdit()
    }

    rightIcon:"images/erase.png"
    rightText:""
    rightlMargin:0
    rightrMargin:0
    righttMargin:4
    rightbMargin:4

    Component.onCompleted: {
        if(rightButton)
            rightButton.visible = false
        if(middleArea)
            middleArea.text=""
    }

    ///////////////////////////
    //interface for use
    function endEdit()//finish edit
    {
        if(middleArea)
            middleArea.focus  = false
    }
    function setUrl(urlText)
    {
        if(middleArea)
            middleArea.text = urlText
    }
    function cancelEdit()
    {
        console.log("function cancelEdit",prevText)
        if(middleArea)
            middleArea.text = prevText
    }

}
