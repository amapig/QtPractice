import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0


CMOS_BasicDialog{
    id:choiceDialog
    property string title: "choice more"
    property int titleFontSize: 36
    property color titleFontColor: "#000000"

    property int choiceItemFontSize:30
    property color choiceItemFontColor:"green"

    property int maxHeight:parent.height-120

    property int columnSpacing:36
    property int listviewSpacing:2

    signal triggered(int index)

    property ListModel listModel:myModel
    property ListView listview:null
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
        ListElement{
            name:"choice 4"
        }
        ListElement{
            name:"choice 5"
        }
        ListElement{
            name:"choice 6"
        }
    }

    property Component listDelegate:myDelegate
    Component{
        id:myDelegate
        Rectangle{
            implicitHeight: choiceDialog.choiceItemFontSize+8
            implicitWidth: parent.width
            Label{
                anchors.centerIn: parent
                text:model.name
                font.pixelSize: choiceDialog.choiceItemFontSize
                color:choiceDialog.choiceItemFontColor
            }
        }
    }
    onCancel:
    {
        triggered(-1)
    }

    contentLabelCmp:Rectangle{
        height:column.height+60
        color:"white"
        radius: 2

        Column{
            id:column
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:choiceDialog.columnSpacing
            Label{
                anchors.horizontalCenter: parent.horizontalCenter
                text:choiceDialog.title
                font.pixelSize: choiceDialog.titleFontSize
                color:choiceDialog.titleFontColor

            }

            ListView{
                id:choiceList    //contentItem property can use as Component simple
                width:parent.width//contentItem.childrenRect.width  //contentWidth //default property from FlickAble
                height:contentItem.childrenRect.height>choiceDialog.maxHeight? maxHeight:contentItem.childrenRect.height //contentHeight //default property from FlickAble
                spacing:choiceDialog.listviewSpacing

                //z:parent.z+1

                model:choiceDialog.listModel
                delegate: choiceDialog.listDelegate


                MouseArea
                {
                    id:listMouseArea
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
