import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

Slider{
    id:slider
    property bool middleEnabled:true
    property real middleValue:0
    property bool foregroundEnabled:true

    property string backgroundImg:"images/borderimg.png"
    property color backgroundColor: "grey"
    property int radius: 4
    property color borderColor: "green"
    property int borderWidth:1

    property color middleColor: "green"
    property color foregroundColor: "blue"

    property int handleHeight:height*2
    property int handleWidth:handleHeight
    property int handleMode:0 //0:circle 1:normal
    property string handleImg:"images/handleimg.png"
    property color handleColor:"white"
    property int handleBorderWidth:1
    property color handleBorderColor:"white"
    property int handleRadius:4


    property int tipRadius:4
    property color tipColor: "grey"
    property int tipBorderWidth:1
    property color tipBorderColor:"black"
    property string tipImg:""
    property bool tipEnabled:true
    property Component tipCmp: tipComponent

    property int tipLeftPadding:10
    property int tipTopPadding:5
    property int tipRightPadding:10
    property int tipBottomPadding :5
    property var tipValue:value
    Component{
        id: tipComponent
        Item{
            implicitWidth: label.width+slider.tipLeftPadding+slider.tipRightPadding
            implicitHeight: label.height+slider.tipTopPadding+slider.tipBottomPadding
            Rectangle{
                visible: slider.tipImg == ""
                anchors.fill: parent
                radius:slider.tipRadius
                color:slider.tipColor
                border.color:slider.tipBorderColor
                border.width:slider.tipBorderWidth
            }
            BorderImage {
                visible: slider.tipImg != ""
                source: slider.tipImg
                anchors.fill: parent
                border.left: 5; border.top: 5
                border.right: 5; border.bottom: 5
            }

            Label{
                id:label
                anchors.centerIn: parent
                text: slider.tipValue
                font.pixelSize: 30
                color:"green"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }
        }
    }

    onValueChanged:{
        if(value > middleValue)
        {
            console.log("onValueChanged:",value,middleValue)
            middleValue = value
        }
    }


    style:SliderStyle{
        groove: Rectangle{
            id:background
            width:control.width
            height:control.height
            color:control.backgroundColor
            radius:control.radius
            border.width: control.borderWidth
            border.color:control.borderColor
            BorderImage {
                id: backImg
                source: control.backgroundImg
                anchors.fill: parent
                border.left: 4; border.top: 2
                border.right: 4; border.bottom: 2
                visible: source != ""
            }

            Rectangle{
                id:middle
                visible:middleEnabled
                anchors.left: parent.left
                height:parent.height
                width:(control.middleValue / (control.maximumValue-control.minimumValue) * parent.width)
                color:control.middleColor
                radius:parent.radius
            }

            Rectangle{
                id:foreground
                height:parent.height
                width:styleData.handlePosition
                color:control.foregroundColor
                visible: control.foregroundEnabled
                radius:parent.radius
                anchors.left: parent.left
            }


        }
        handle:Item{
            width:control.handleWidth
            height:control.handleHeight
            Canvas{
                id:canvas
                anchors.fill: parent
                smooth: true
                visible: control.handleMode == 0
                width:control.height*3
                height:width
                onImageLoaded: {
                    requestPaint()
                }
                onPaint: {
                    if(!context)
                        getContext('2d')
                    if(context)
                    {
                        var radius = Math.min(width,height)/2-2
                        context.beginPath();
                        context.arc(width/2,height/2,radius,0,Math.PI*2,true); // Outer circle
                        context.lineWidth = control.handleBorderWidth
                        context.stroke();
                        context.clip()
                        context.fillStyle=control.handleColor
                        context.strokeStyle=control.handleBorderColor
                        context.fill()
                        if(control.handleImg != "")
                            context.drawImage(control.handleImg,width/2-radius,height/2-radius,radius*2,radius*2)
                    }
                }

            }//~canvas
            Item{
                anchors.fill: parent
                visible: control.handleMode == 1
                Rectangle{
                    visible: control.handleImg ==""
                    anchors.fill: parent
                    border{width:control.handleBorderWidth;color:control.handleBorderColor}
                    radius:control.handleRadius
                    color:control.handleColor
                }

                Image{
                    visible: control.handleImg !=""
                    anchors.fill: parent
                    source:control.handleImg
                    fillMode: Image.PreserveAspectFit
                }
            }

            Loader{
                id:tipLoader
                visible: control.pressed&&control.tipEnabled
                sourceComponent: control.tipCmp
                anchors.bottom:parent.top
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
            }
         }//~handle
    }//~style

}
