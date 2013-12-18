import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import com.cmos.widget 1.0
Button{
    id:buttonRoot
    UIConst{
        id: constUi
    }
    property int  factor: constUi.getValue("factor")

    property bool isHorizontal: false //true:icon left text right  false:reverse
    property bool isIconBefore:false
    property bool isBgUseImage:false
    property bool enableBackground:true

    property color fontColor:pressed?"#ffffff":"#1ca72b"
    property color bgColor:!enabled?"grey":pressed?"#1ca72b":"#ffffff"
    property int fontSize: 36 * factor
    property string bgIconSource:!enabled?"images/bnbg2zhihui.png":
                                           pressed?"images/bnbgactive.png":"images/bnbg.png"

    property int borderWidth: 1
    property color borderColor: "black"

    property int lMargin:30
    property int rMargin:30
    property int tMargin:16
    property int bMargin:16

    property int spacing:20 * factor

    style:(text!=""&&iconSource!="")?iconTextStyleCmp:
          iconSource!=""?iconStyleCmp:
          text!=""? textStyleCmp :iconStyleCmp

    Component{
        id:imageBg
        BorderImage {
            visible: buttonRoot.enableBackground
            border.left: 5; border.top: 5
            border.right: 5; border.bottom: 5
            source: buttonRoot.bgIconSource
             //fillMode:Image.PreserveAspectFit
        }
    }
    Component{
        id:rectBg
        Rectangle{
            visible: buttonRoot.enableBackground
            color:buttonRoot.bgColor
            border{
                width:buttonRoot.borderWidth
                color:buttonRoot.borderColor
            }
            radius: 4
            /*
            implicitWidth:90
            implicitHeight:38*/
        }
    }

    Component{
        id:textStyleCmp
        ButtonStyle{
            padding {
                top: buttonRoot.tMargin
                left: buttonRoot.lMargin
                right: buttonRoot.rMargin
                bottom: buttonRoot.bMargin
            }

            background: buttonRoot.isBgUseImage?imageBg:rectBg
            label:Label{
                text:control.text
                color:buttonRoot.fontColor
                font.pixelSize: buttonRoot.fontSize
                anchors.centerIn: parent
            }
        }//text Style

    }

    Component{
        id:iconStyleCmp
        ButtonStyle{
            padding {
                top: buttonRoot.tMargin
                left: buttonRoot.lMargin
                right: buttonRoot.rMargin
                bottom: buttonRoot.bMargin
            }

            background: buttonRoot.isBgUseImage?imageBg:rectBg

            label:Image{
                source:control.iconSource
                fillMode: Image.PreserveAspectFit
            }
        }//iconStyle

    }
    Component{
        id:iconTextStyleCmp
        ButtonStyle{
            padding {
                top: buttonRoot.tMargin
                left: buttonRoot.lMargin
                right: buttonRoot.rMargin
                bottom: buttonRoot.bMargin
            }
//
            background: buttonRoot.isBgUseImage?imageBg:rectBg

            label:isHorizontal?rowCmp:columnCmp
            Component{
                id:columnCmp
                Column{
                    spacing:buttonRoot.spacing
                    Image{
                        anchors.horizontalCenter: parent.horizontalCenter
                        source:control.iconSource
                        fillMode: Image.PreserveAspectFit
                    }
                    Label{
                        text:control.text
                        font.pixelSize: buttonRoot.fontSize
                        color:buttonRoot.fontColor
//                        horizontalAlignment: Qt.AlignHCenter
//                        verticalAlignment: Qt.AlignVCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }//ColumnComponent
           Component{
               id:rowCmp
               Row{
                    spacing:buttonRoot.spacing
                    layoutDirection:buttonRoot.isIconBefore?Qt.LeftToRight:Qt.RightToLeft
                    Image{
                        anchors.verticalCenter: parent.verticalCenter
                        source:control.iconSource
                        fillMode: Image.PreserveAspectFit
                    }
                    Label{
                        text:control.text
                        font.pixelSize: buttonRoot.fontSize
                        color:buttonRoot.fontColor
//                        horizontalAlignment: Qt.AlignHCenter
//                        verticalAlignment: Qt.AlignVCenter
                    }
               }
           }//~RowComponent
        }//iconText Style

    }


}
