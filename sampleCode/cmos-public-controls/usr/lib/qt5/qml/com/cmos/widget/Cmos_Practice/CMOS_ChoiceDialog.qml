import QtQuick 2.0
import QtQuick.Controls 1.0
import com.cmos.widget 1.0

CMOS_BasicDialog{
    id:choiceDialog
    UIConst{
        id: constUi
    }
    property real  factor: constUi.getValue("scale")
    property string title: ""
    property int titleFontSize: 36 * factor
    property color titleFontColor: "#000000"

    property int choiceItemFontSize:30 * factor
    property color choiceItemFontColor:"#000000"

    property int maxHeight:parent.height-120

    property int columnSpacing:36 * factor
    property int listviewSpacing:0

    signal triggered(int index)

    property QtObject listModel:myModel
    property ListView listview:null

    property bool lvInteractive:true
    property bool enabledDefauleEvent:true

    property int delegateHeight:110 * factor
    property int delegateBorderWidth:1
    property color delegateBorderColor:"grey"
    property int delegateRadius:0
    property color delegateBgColor:"white"
    property real delegateOpacity:1

    property int contentBorderWidth:1
    property color contentBorderColor:"grey"
    property real contentOpacity:1
    property int contentRadius:0
    property color contentBgColor:"white"



    clip:true
    ListModel{
        id:myModel
        ListElement{
            name:"choice 1"
        }
        ListElement{
            name:"choice 2"
        }
        ListElement{
            name:"choice 3"
        }
//        ListElement{
//            name:"choice 4"
//        }
//        ListElement{
//            name:"choice 5"
//        }
//        ListElement{
//            name:"choice 6"
//        }
//        ListElement{
//            name:"choice 7"
//        }
//        ListElement{
//            name:"choice 8"
//        }
    }

    property Component listDelegate:myDelegate
    Component{
        id:myDelegate
        Rectangle{
            implicitHeight: choiceDialog.delegateHeight
            implicitWidth: parent.width
            border.width: choiceDialog.delegateBorderWidth
            border.color:choiceDialog.delegateBorderColor
            radius:choiceDialog.delegateRadius
            opacity:choiceDialog.delegateOpacity
            color:choiceDialog.delegateBgColor
            Label{
                anchors.fill: parent
                text:model.name
                font.pixelSize: choiceDialog.choiceItemFontSize
                color:choiceDialog.choiceItemFontColor
                anchors.leftMargin: 62
                verticalAlignment: Qt.AlignVCenter
            }
        }
    }
    onCancel:
    {
        triggered(-1)
    }

    contentLabelCmp:Rectangle{
        height:column.height//choiceDialog.title!=""?(column.height+choiceDialog.columnSpacing):column.height
        width:choiceDialog.width

        border.width: choiceDialog.contentBorderWidth
        border.color:choiceDialog.contentBorderColor
        radius:choiceDialog.contentRadius
        opacity:choiceDialog.contentOpacity
        color:choiceDialog.contentBgColor

        Column{
            id:column
            anchors.verticalCenter: parent.verticalCenter
//            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width
            spacing:choiceDialog.columnSpacing
            Label{
                id:titleLabel
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Qt.AlignBottom
                text:choiceDialog.title
                font.pixelSize: choiceDialog.titleFontSize
                color:choiceDialog.titleFontColor
                z:choiceList.z+1
                height:choiceDialog.title==""?0:(choiceDialog.titleFontSize+choiceDialog.columnSpacing)
            }

            ListView{
                id:choiceList    //contentItem property can use as Component simple
                width:parent.width//contentItem.childrenRect.width  //contentWidth //default property from FlickAble
                height:Math.min(contentItem.childrenRect.height+titleLabel.height,choiceDialog.maxHeight)//contentItem.childrenRect.height>choiceDialog.maxHeight? maxHeight:contentItem.childrenRect.height //contentHeight //default property from FlickAble
                spacing:choiceDialog.listviewSpacing
                interactive: choiceDialog.lvInteractive
                //z:parent.z+1
                clip:true
                model:choiceDialog.listModel
                delegate: choiceDialog.listDelegate


                MouseArea
                {
                    id:listMouseArea
                    enabled: choiceDialog.enabledDefauleEvent
                    anchors.fill: parent
                    onClicked: {
                        console.log("CMOS_PopupMenu:listMouseArea click",choiceList.width,choiceList.height,choiceList.contentItem.childrenRect.width,choiceList.contentItem.childrenRect.height,choiceList.contentItem.width,choiceList.contentItem.height,choiceList.count)
                        var index = choiceList.indexAt(choiceList.contentX+mouseX,choiceList.contentY+mouseY)
                        if(index == -1)
                            return
                        //choiceList.currentIndex = index
                        console.log("CMOS_PopupMenu:listMouseArea click",index)
                        choiceDialog.triggered(index)
                    }
                    onPressAndHold: {
                        console.log("CMOS_ChoiceList:listMouseArea press and hold")
                    }
                }

                Component.onCompleted:  choiceDialog.listview = choiceList
            }


        }

    }
}
