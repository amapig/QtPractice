import QtQuick 2.0

Rectangle {
    id:rectRoot
    property bool powerState:false
    property string onImg:"images/switchon.png"
    property string offImg:"images/switchoff.png"
    property string onText:"On"
    property string offText:"Off"
    property string btnImg:"images/switchbn.png"
    property bool isUseImg:true

    signal switchChanged(bool isOn)


    onPowerStateChanged: {
        console.log("onPowerStateChanged",powerState)
        switchChanged(powerState)
        changeSwitch()
    }
    function changeSwitch()
    {
        if(powerState)
        {
            switchBtn.anchors.horizontalCenter=switchOff.horizontalCenter
            anchors.horizontalCenterOffset = 1
        }
        else
        {
            switchBtn.anchors.horizontalCenter=switchOn.horizontalCenter
            anchors.horizontalCenterOffset = -1
        }
    }
    Component.onCompleted: {
        changeSwitch()
    }
    //clip:true
    implicitWidth: 160
    implicitHeight: 72
    color:"white"
    border.width: 1
    border.color: "grey"
    radius:height/2
    CMOS_Button{
        id:switchOn
        lMargin: 0
        rMargin:0
        tMargin:0
        bMargin:0
        anchors.left: parent.left
        anchors.leftMargin: parent.height/4
        anchors.verticalCenter: parent.verticalCenter

        borderWidth: 0
        isBgUseImage: isUseImg
        bgColor: "white"
        bgIconSource: onImg
        text:!isUseImg?onText:""
        onClicked:{
            console.log("switchOn onClicked")
            powerState = !powerState
        }
    }
    CMOS_Button{
        id:switchOff
        lMargin:0
        rMargin:0
        tMargin:0
        bMargin:0
        anchors.right: parent.right
        anchors.rightMargin: parent.height/4
        anchors.verticalCenter: parent.verticalCenter
        bgColor: "white"
        borderWidth: 0
        isBgUseImage: isUseImg
        text:!isUseImg?offText:""
        bgIconSource: offImg
        onClicked:{
            console.log("switchOff onClicked")
            powerState = !powerState
        }
    }

    CMOS_Button{
        id:switchBtn
        lMargin:0
        rMargin:0
        tMargin:0
        bMargin:0
        //height:parent.height
        borderWidth: 0
        bgColor: "white"
        isBgUseImage: true
        //anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        bgIconSource: btnImg
        onClicked:{
            console.log("switchBtn onClicked")
            powerState = !powerState
        }
    }

}
