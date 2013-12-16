import QtQuick 2.0

CMOS_BasicTitleBar{
    id:topTitleBar
    signal goback()
    implicitWidth: parent.width
    implicitHeight: 94
    lMargin: 20
    tMargin: 20
    bMargin: 20
    rMargin: 20
    spacing:20

    enableMiddle: false
    enableRight: false

    leftBorderWidth: 0
    rightBorderWidth: 0

    leftIcon: !leftEnabled? "images/backico-zhihui.png":
                            leftPressed?"images/backico-active.png":"images/backico.png"
    leftText:""
//    rightIcon: "images/moreico.png"
//    rightText:""
//    title:"topic title text"
    onLTrigger: goback()
//    onRTrigger: leftEnabled = !leftEnabled

    anchors.top: parent.top
    anchors.left:parent.left
    anchors.right: parent.right
    anchors.margins:0
    z:parent.z+1
}
