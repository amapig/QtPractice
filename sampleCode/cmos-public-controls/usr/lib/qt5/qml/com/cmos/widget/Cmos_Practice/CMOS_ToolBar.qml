import QtQuick 2.0
import QtQuick.Controls 1.0
import com.cmos.widget 1.0
CMOS_BasicTitleBar{
    id:toolBar
    UIConst{
        id: constUi
    }
    property int  factor: constUi.getValue("factor")
    height:180 * factor
    spacing: 56 * factor
    enableLeft: false
    enableRight: false
    enableMiddle: true
    property ListModel repeatModel:myRepeatModel
    property Component itemDelegate:buttonDelegate
    signal trigger(int index)

    isBgUseImage: false
    bgImgSource: "images/bnbgactive.png"

    property bool enableDelegateBg:false
    property QtObject delegateObj:QtObject{
        id:delegateObject
        property bool isHorizontal: false //true:icon left text right  false:reverse
        property bool isIconBefore:false
        property bool isBgUseImage:false

        property color fontColor:"#000000"
        property color bgColor:"#ffffff"
        property int fontSize: 26 * factor
        property string bgIconSource:"images/bnbg.png"
        property int borderWidth: 0
        property color borderColor: "black"

        property int spacing: 6 * factor
        property int lMargin:1
        property int rMargin:1
        property int tMargin:1
        property int bMargin:1
    }

    Component{
           id:buttonDelegate
           CMOS_Button{
               borderWidth: delegateObj.borderWidth
               borderColor: delegateObj.borderColor
               fontColor: delegateObj.fontColor
               fontSize: delegateObj.fontSize
               text:model.title
               iconSource: !pressed?model.imgUrl:(model.activeImgUrl != undefined&&model.activeImgUrl!=""?model.activeImgUrl:model.imgUrl)

               lMargin:delegateObj.lMargin
               rMargin:delegateObj.rMargin
               tMargin:delegateObj.tMargin
               bMargin:delegateObj.bMargin

               spacing:delegateObj.spacing

               isHorizontal: delegateObj.isHorizontal
               isIconBefore:delegateObj.isIconBefore
               isBgUseImage:delegateObj.isBgUseImage

               bgColor:delegateObj.bgColor
               bgIconSource:delegateObj.bgIconSource

               enableBackground: toolBar.enableDelegateBg

               onClicked: toolBar.trigger(index)
           }

    }
    ListModel{
        id:myRepeatModel

        ListElement{
            imgUrl:"images/deleteico.png"
            activeImgUrl:""
            title:"返回"
        }
        ListElement{
            imgUrl:"images/search.png"
            activeImgUrl:""
            title:"更多"
        }
        ListElement{
            imgUrl:"images/deleteico.png"
            activeImgUrl:""
            title:"置顶"
        }

    }
    middleComponent: Item{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            Row{
                spacing:toolBar.spacing
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Repeater{
                    model:toolBar.repeatModel
                    delegate:toolBar.itemDelegate
                }
        }
    }
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    z:parent.z+1

    Component.onCompleted: {
        if(background)background.height = 180
    }
}
