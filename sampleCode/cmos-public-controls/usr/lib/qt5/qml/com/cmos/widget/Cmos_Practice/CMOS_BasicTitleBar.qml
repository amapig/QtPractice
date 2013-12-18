import QtQuick 2.0
import QtQuick.Controls 1.0

import com.cmos.widget 1.0
Item {
    id:basicBar
    UIConst{
        id: constUi
    }
    property int  factor: constUi.getValue("factor")
    property bool alwaysMiddle: true
    property int  middleOffset: 0

    implicitWidth: parent.width
    implicitHeight:94 * factor

    signal lTrigger()
    signal rTrigger()

    //margins
    property int lMargin:20
    property int rMargin:20
    property int tMargin:10
    property int bMargin:14
    //space between items
    property int spacing:20 * factor

    property bool enableLeft:true
    property bool enableMiddle:true
    property bool enableRight:true

    property bool leftEnabled: true
    property bool rightEnabled: true

    property string title :""
    property color titleColor: "#000000"
    property int titleFontSize: 36 * factor

    property string leftText:"取消"
    property string leftIcon:""//images/backico.png
    property bool leftPressed: false

    property string rightText:""//取消全选
    property string rightIcon:"images/moreico.png"
    property bool rightPressed:false


    property bool leftIsHorizontal: false //true:icon left text right  false:reverse
    property bool leftIsIconBefore:false
    property bool leftIsBgUseImage:false

    property color leftFontColor:leftPressed?"#ffffff":"#1ca72b"
    property color leftBgColor:leftPressed?"#1ca72b":"#ffffff"
    property int leftFontSize: 36  * factor
    property string leftBgIconSource: leftPressed?"images/bnbgactive.png":"images/bnbg.png"
    property int leftBorderWidth: 1
    property color leftBorderColor: "black"
    property int leftSpacing: 20  * factor
    property int leftlMargin:30
    property int leftrMargin:30
    property int lefttMargin:16
    property int leftbMargin:16

    property bool rightIsHorizontal: false //true:icon left text right  false:reverse
    property bool rightIsIconBefore:false
    property bool rightIsBgUseImage:false

    property color rightFontColor:rightPressed?"#ffffff":"#1ca72b"
    property color rightBgColor:rightPressed?"#1ca72b":"#ffffff"
    property int rightFontSize: 36  * factor
    property string rightBgIconSource:rightPressed?"images/bnbgactive.png":"images/bnbg.png"
    property int rightBorderWidth: 1
    property color rightBorderColor: "black"

    property int rightSpacing: 20 * factor
    property int rightlMargin:30
    property int rightrMargin:30
    property int righttMargin:16
    property int rightbMargin:16

    property color bgColor:"white"
    property color bgBorderColor:"#accccc"
    property int bgBorderWidth:1
    property string bgImgSource:""
    property bool isBgUseImage:false


    property Component leftButtonStyle:null
    property Component rightButtonStyle:null

    property Component backgroundComponent:isBgUseImage?bgImgCmp:bgRectCmp

    property CMOS_Button leftButton:leftLd.item
    property CMOS_Button rightButton:rightLd.item
    property Item middleArea :middleLd.item
    property Item background :backgroundLd.item


    property Component leftComponent: lCmp
    property Component middleComponent:mCmp
    property Component rightComponent:rCmp
    MouseArea{ //just for filter event
        anchors.fill: parent
    }

    onLeftEnabledChanged:  {
        if(leftButton != undefined)
            leftButton.enabled = leftEnabled
    }
    onRightEnabledChanged: {
        rightLd.item.enabled = rightEnabled
    }

    Component{
        id:bgRectCmp
        Rectangle{
            implicitWidth: parent.width
            height:90
            color:basicBar.bgColor
            border{
                width:basicBar.bgBorderWidth
                color:basicBar.bgBorderColor
            }
            radius:4
        }
    }
    Component{
        id:bgImgCmp
        Image{
            source:basicBar.bgImgSource
            fillMode: Image.Stretch //PreserveAspectFit
        }
    }





    Component{
        id:lCmp
        CMOS_Button{
            text:leftText
            iconSource: leftIcon

            isHorizontal: basicBar.leftIsHorizontal
            isIconBefore:basicBar.leftIsIconBefore
            isBgUseImage:basicBar.leftIsBgUseImage

            fontColor:basicBar.leftFontColor
            bgColor:basicBar.leftBgColor
            fontSize: basicBar.leftFontSize
            bgIconSource:basicBar.leftBgIconSource

            lMargin:basicBar.leftlMargin
            rMargin:basicBar.leftrMargin
            tMargin:basicBar.lefttMargin
            bMargin:basicBar.leftbMargin

            borderWidth:basicBar.leftBorderWidth
            borderColor: basicBar.leftBorderColor


            onClicked: basicBar.lTrigger()
            Component.onCompleted: {
                if(basicBar.leftButtonStyle != null)
                {
                    style = basicBar.leftButtonStyle
                }
                enabled = basicBar.leftEnabled
            }

            onPressedChanged: {
                console.log("if is enabled:",enabled)
                 basicBar.leftPressed = pressed
            }
            onEnabledChanged: {
                basicBar.leftEnabled = enabled
                console.log("left areaonEnabledChanged",enabled)
            }
        }
    }
    Component{
        id:mCmp
        Label{
            id:titleLabel
            clip:true
            //elide: Text.Right
            text:basicBar.title
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            font.pixelSize: titleFontSize
            color:titleColor
            elide: Text.ElideRight
        }
    }
    Component{
        id:rCmp
        CMOS_Button{
            text:rightText
            iconSource: rightIcon

            isHorizontal: basicBar.rightIsHorizontal
            isIconBefore:basicBar.rightIsIconBefore
            isBgUseImage:basicBar.rightIsBgUseImage

            fontColor:basicBar.rightFontColor
            bgColor:basicBar.rightBgColor
            fontSize: basicBar.rightFontSize
            bgIconSource:basicBar.rightBgIconSource

            lMargin:basicBar.rightlMargin
            rMargin:basicBar.rightrMargin
            tMargin:basicBar.righttMargin
            bMargin:basicBar.rightbMargin

            borderWidth:basicBar.leftBorderWidth
            borderColor: basicBar.leftBorderColor

            onClicked: basicBar.rTrigger()
            Component.onCompleted: {
                if(basicBar.rightButtonStyle != null)
                {
                    style = basicBar.rightButtonStyle
                }

                enabled = basicBar.rightEnabled
            }

            onPressedChanged: {
                 basicBar.rightPressed = pressed
            }

            onEnabledChanged: {
                basicBar.rightEnabled = enabled
            }
        }
    }

    function calcu()
    {
        if(alwaysMiddle)
        {
            var leftw = leftLd.item ? leftLd.item.width :  0
            var rightw = rightLd.item ? rightLd.item.width :  0
            middleOffset = Math.max(leftw, rightw)
            //console.log(middleOffset)
            middleLd.anchors.leftMargin = basicBar.spacing + middleOffset - leftLd.width
            middleLd.anchors.rightMargin = basicBar.spacing + middleOffset - rightLd.width
            //console.log(middleLd.anchors.leftMargin, middleLd.anchors.rightMargin)
        }
    }

    Loader{
        id:backgroundLd
        sourceComponent: backgroundComponent
        anchors.fill: parent

        Loader{
            z:parent.z+1
            id:leftLd
            visible: enableLeft
            sourceComponent: enableLeft?leftComponent:null
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin:basicBar.lMargin
            anchors.topMargin: basicBar.tMargin
            anchors.bottomMargin: basicBar.bMargin

            onLoaded: {
                calcu()
            }
        }

        Loader {
            z:parent.z+1
            width: parent.width - rightLd.width - leftLd.width
            id:middleLd
            visible: enableMiddle
            anchors.left: leftLd.right
            anchors.right: rightLd.left
            anchors.leftMargin: basicBar.spacing
            anchors.rightMargin:basicBar.spacing
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: basicBar.tMargin
            anchors.bottomMargin: basicBar.bMargin
            sourceComponent:enableMiddle?middleComponent:null

            onLoaded: {
                calcu()
            }
        }
        Loader {
            z:parent.z+1
            id:rightLd
            visible: enableRight
            anchors.right: parent.right
            anchors.rightMargin:basicBar.rMargin
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: basicBar.tMargin
            anchors.bottomMargin: basicBar.bMargin
            sourceComponent:enableRight?rightComponent:null

            onLoaded: {
                calcu()
            }
        }
    }



}
