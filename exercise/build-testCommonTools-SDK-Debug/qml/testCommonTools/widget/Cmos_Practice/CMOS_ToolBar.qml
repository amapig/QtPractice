import QtQuick 2.0
import QtQuick.Controls 1.0

CMOS_BasicTitleBar{
    id:toolBar
    height:180
    spacing: 56
    enableLeft: false
    enableRight: false
    enableMiddle: true
    property ListModel repeatModel:myRepeatModel
    property Component itemDelegate:buttonDelegate
    signal trigger(int index)

    isBgUseImage: false
    bgImgSource: "images/bnbgactive.png"


    Component{
           id:buttonDelegate
           CMOS_Button{
               borderWidth: 0
               fontColor: "#000000"
               fontSize: 26
               text:model.title
               iconSource: model.imgUrl

               lMargin:1
               rMargin:1
               tMargin:1
               bMargin:1

               spacing:6

               onClicked: toolBar.trigger(index)
           }
    }
    ListModel{
        id:myRepeatModel

        ListElement{
            imgUrl:"images/deleteico.png"
            title:"返回"
        }
        ListElement{
            imgUrl:"images/search.png"
            title:"更多"
        }
        ListElement{
            imgUrl:"images/deleteico.png"
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
        background.height = 180
    }
}
