import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

Item{
    width:720
    height:720

    Row{
        id:buttonRow
        spacing:5
        CMOS_Button{
            text:"ChoiceD"
            //anchors.verticalCenter: parent.verticalCenter
            //anchors.right: parent.right
            //width:parent.width
            //fontColor: pressed?"yellow":"black"
            //bgColor: pressed?"white":"red"
            isBgUseImage: true
            enabled: true
            bgIconSource: !enabled?"images/bnbg2zhihui.png":
                                    pressed?"images/bnbg2active.png":"images/bnbg2.png"
            onClicked:choiceDialog.visible = true
        }
        //    //CMOS_IconButton{
        CMOS_Button{
            //anchors.left: parent.left
            iconSource: pressed?"images/next.png":"images/prev.png"
            onClicked:confirmDialog.visible = true
        }

        //    //CMOS_IconTextButton{
        CMOS_Button{
            iconSource: "images/prev.png"
            text:"inputD"
            //anchors.right:parent.right
            //width:parent.width
            isHorizontal: true
            isIconBefore: false
            onClicked: {
                inputDialog.visible = true
            }
        }
        CMOS_Button{
            text:"BasicD"
            onClicked: {
                basicDialog.visible = true
            }
        }
    }

    CMOS_ChoiceDialog{
        id:choiceDialog
        visible:false
        title:"添加更多选项"
        Component.onCompleted: {
            listview.currentIndex = 4

        }
        onTriggered:
        {
            console.log("choiceDialog trigger index:",index)
            if(index > 3)
                listview.currentIndex = 0
            else
                listview.currentIndex = 4
        }
    }
    CMOS_ConfirmDialog{
        id:confirmDialog
        visible:false
        title:"您确定将此联系人加入黑名单吗"
        Component.onCompleted: {
            cancleButton.text="haha"
        }
    }
    CMOS_InputDialog{
        id:inputDialog
        visible:false
        anchors.top: parent.top
        title:"您确定吗?"
        placeholderText:"请输入名称"
        onAccepted: {
            console.log("accept is result is:",value)
        }
        Component.onCompleted: {
            cancleButton.text="haha"
            txtField.placeholderText = "test haha"
        }
    }
    CMOS_BasicDialog{
        id:basicDialog
        visible:false
    }

    Row{
        id:titleRow
        anchors.top:buttonRow.bottom
        CMOS_Button{
            text:"BasicTB"
            onClicked:basicTitleBar.visible = !basicTitleBar.visible
        }
        CMOS_Button{
            text:"InputTB"
            onClicked:inputBar.visible = !inputBar.visible
        }
        CMOS_Button{
            text:"EditTB"
            onClicked:editBar.visible = !editBar.visible
        }
        CMOS_Button{
            text:"TopTB"
            onClicked:topTitleBar.visible = !topTitleBar.visible
        }
    }



    CMOS_BasicTitleBar{
        id:basicTitleBar
        visible:false
        //y:100
        //        middleComponent: CMOS_IconButton{
        //            CMOS_IconButton{
        //                iconSource: "images/erase.png"
        //            }
        //        }
        onLTrigger: visible = !visible
        anchors.top: fiveRow.bottom
    }
    CMOS_LineEdit{
        id:lineEdit
        anchors.top: fiveRow.bottom
        anchors.margins: 5
        visible:false
        onTextChanged: {
            console.log("CMOS_LineEdit onTextChanged:",lineEdit.getText())
        }
    }

    CMOS_InputTitleBar{
        id:inputBar
        visible:false
        anchors.top: fiveRow.bottom
        anchors.topMargin: 5
        Component.onCompleted: {
            middleArea.middleArea.text = "red "
        }

        onTextChanged: {
            console.log("CMOS_InputTitleBar onTextChanged:",inputBar.getText())
        }
        onLTrigger: visible = !visible
    }
    CMOS_EditTitleBar{
        id:editBar
        anchors.top: fiveRow.bottom
        anchors.topMargin: 5
        visible:false
        onLTrigger: visible = !visible
    }


    CMOS_TopTitleBar
    {
        id:topTitleBar
        visible:false
        onGoback: {visible = !visible
            listViewRect.visible = false
        }
    }

    Row{
        id:checkRow
        anchors.top:titleRow.bottom
        CMOS_Button{
            text:"ToolB"
            onClicked:toolBar.visible = !toolBar.visible
        }
        CMOS_Button{
            text:"RoundImg"
            onClicked:roundImage.visible = !roundImage.visible
        }
        CMOS_Button{
            text:"CBox1"
            onClicked:checkBox1.visible = !checkBox1.visible
        }
        CMOS_Button{
            text:"CBox2"
            onClicked:checkBox2.visible = !checkBox2.visible
        }
    }

    Row{
        id:fourRow
        anchors.top:checkRow.bottom
        CMOS_Button{
            text:"LineEdit"
            onClicked:lineEdit.visible = !lineEdit.visible
        }
        CMOS_Button{
            text:"Polygon"
            onClicked:drwaPolygon.visible = !drwaPolygon.visible
        }
        CMOS_Button{
            text:"swtch"
            onClicked:swtch.visible = !swtch.visible
        }
    }

    Row{
        id:fiveRow
        anchors.top:fourRow.bottom
        CMOS_Button{
            text:"ListView"
            onClicked:{

                listViewRect.visible = !listViewRect.visible
                topTitleBar.visible = true
            }
        }
        CMOS_Button{
            text:"TabView"
            onClicked:tabView.visible = !tabView.visible
        }
        CMOS_Button{
            text:"Spinner"
            onClicked:spinnerBase.visible = !spinnerBase.visible
        }
    }


    CMOS_ToolBar{
        id:toolBar
        spacing:180
        isBgUseImage: false
        visible:false
        //bgImgSource: "images/bnbgactive.png"

        repeatModel: ListModel{
            ListElement{
                imgUrl:"images/deleteico.png"
                title:"删除"
            }

            ListElement{
                imgUrl:"images/deleteico.png"
                title:"置顶"
            }
        }
        onTrigger: visible = !visible//console.log("CMOS_ToolBar is trigger:",index)
    }

    //    CMOS_Delegate{
    //        isEditMode : false
    //        canDrag: true
    //    }


    Rectangle {
        id:listViewRect
        visible: false
        anchors.top: fiveRow.bottom
        width:parent.width
        anchors.bottom: parent.bottom
        CMOS_ListView{

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
                ListElement{
                    name:"choice 7"
                }
                ListElement{
                    name:"choice 8"
                }
                ListElement{
                    name:"choice 9"
                }
                ListElement{
                    name:"choice 10"
                }
            }
            ///for test
            Rectangle{
                id:leftValueBar
                width:100
                height:100
                color:"red"
                visible: false
                CMOS_Button{
                    text:"left"
                    onClicked: console.log("hahhahhahahahhahhokle")
                }

            }
            Rectangle{
                id:rightValueBar
                width:100
                height:100
                color:"yellow"
                visible: false
                CMOS_Button{
                    text:"right"
                    onClicked: console.log("hahhahhahahahhahhokle")
                }

            }
            ///for test

            property Component listDelegate:CMOS_Delegate{
                id:cmosDelegate
                canDrag:true
                canTag: false
                isEditMode: false
                leftBar: leftValueBar
                rightBar:rightValueBar
            }

            model:myModel
            delegate:listDelegate
            spacing:0


            onDeleteItems: {
                console.log("onDeleteItems:",indexList.length)
                for(var i=indexList.length-1;i>= 0;i--)
                    myModel.remove(indexList[i])
            }
        }
    }



    CMOS_RoundImage{
        id:roundImage
        visible: false
        anchors.top: fiveRow.bottom
    }


    CMOS_DrawPolygon{
        id:drwaPolygon
        width:300
        height:150
        bgFillMode: 0
        isFillMode: true
        visible:false
        anchors.top: fiveRow.bottom
    }

    //    CMOS_ChoiceList{
    //        values:[["0","0"],["1","1"],["2","2"],["3","3"]]
    //        Component.onCompleted: {
    //            for(var i = 0;i < values.length;i++)
    //            {
    //                console.log("Component.onCompleted i:",i,values[i][0],values[i][1])
    //            }
    //        }
    //    }

    CMOS_Switch{
        id:swtch
        isUseImg:true
        visible:false
        anchors.top: fiveRow.bottom
    }

    CMOS_CheckBox{
        id:checkBox1
        source:"images/icontagon.png"//checked?"images/icontagon.png":"images/icontagoff.png"
        visible: false
        anchors.top: fiveRow.bottom
        borderWidth: 1

    }
    CMOS_CheckBox{
        id:checkBox2
        source:checked?"images/icontagon.png":"images/icontagoff.png"
        visible: false
        anchors.top: fiveRow.bottom
        anchors.right: parent.right
    }
/*
    Rectangle{
        id:tabView
        width:parent.width
        anchors.bottom: parent.bottom
        anchors.top: fiveRow.bottom
        visible:false
        CMOS_TabView{


            theight: 50


            Tab {
                id: tab1
                objectName: "tab1"
                title: "Tab1"
                Column {
                    id: column_in_tab1
                    objectName: "column_in_tab1"
                    anchors.fill: parent
                    CMOS_Button {
                        id: tab1_btn1
                        objectName: "tab1_btn1"
                        text: "button 1 in Tab1"
                    }
                    CMOS_Button {
                        id: tab1_btn2
                        objectName: "tab1_btn2"
                        text: "button 2 in Tab1"
                    }
                }
            }
            Tab {
                id: tab2
                objectName: "tab2"
                title: "Tab2"
                Column {
                    id: column_in_tab2
                    objectName: "column_in_tab2"
                    anchors.fill: parent
                    CMOS_Button {
                        id: tab2_btn1
                        objectName: "tab2_btn1"
                        text: "button 1 in Tab2"
                    }
                    CMOS_Button {
                        id: tab2_btn2
                        objectName: "tab2_btn2"
                        text: "button 2 in Tab2"
                    }
                }
            }
        }
    }
    */
    /*SpinnerBase{
        id:spinnerBase
        anchors.top: fiveRow.bottom
        visible:false
        width:300
        height:100
        anchors.margins: 6;
      */  // test use background
        /*
             注意：若使用“background”属性，则必须要有一个背景，
                  可以使用空背景，或者不设置“background”属性
           */
 /*       background: backgroudSource;
        // test use model
        model: modelSource
        // test Rotation and test currentIndex() interface
        textRotation: (currentIndex() % 2) ? -10 : 10
        // test fontPixelSize
        pixelSize: 36
        // test currentData() interface

        onCurrentIndexChenged: {
            console.log("currentText ================= ",currentText());
        }

        Component.onCompleted: {//show currentText when the application start
            console.log("currentText ================= ",currentText());
        }
    }*/

    Component{ // 可以使用任何的资源放在 backgroudSource 作为背景
        id: backgroudSource

        // ================================= test background 0 空背景

        //        Item{}

        // ================================= test background 1

        Rectangle{
            radius: 20;
            gradient: Gradient{
                GradientStop{ position: 0.0; color: "black" }
                GradientStop{ position: 0.18; color: "gray" }
                GradientStop{ position: 0.33; color: "white" }
                GradientStop{ position: 0.66; color: "gray" }
                GradientStop{ position: 1.0; color: "black" }
            }
        }

        // ================================= test background 2

        //        Rectangle{
        //            color: "lightGreen"
        //        }

        // ================================= test background 3

        //        Image {
        //            source: "filePath"
        //        }
    }

    ListModel { // 可以使用任何的字符为content赋值
        id: modelSource

        // example data 1

        //        ListElement { content: "2" }
        //        ListElement { content: "3" }
        //        ListElement { content: "4" }

        // example data 2

        ListElement { content: "星期一" }
        ListElement { content: "星期二" }
        ListElement { content: "星期三" }
        ListElement { content: "星期四" }
        ListElement { content: "星期五" }
        ListElement { content: "星期六" }
        ListElement { content: "星期日" }
    }

}
/*
CMOS_Page{


    initialItem: Rectangle{
        id:initItem
        color:"red"
    }
    stackViewDelegate: StackViewDelegate {
                           function transitionFinished(properties)
                           {
                               properties.exitItem.opacity = 1
                           }

                           property Component pushTransition: StackViewTransition {
                               PropertyAnimation {
                                   target: enterItem
                                   property: "opacity"
                                   from: 0
                                   to: 1
                               }
                               PropertyAnimation {
                                   target: exitItem
                                   property: "opacity"
                                   from: 1
                                   to: 0
                               }
                           }
                       }

    CMOS_ToolBar{
        anchors.top: parent.verticalCenter
        enableNext: true
        onGoPrev: stackView.push(yellowRect)
        onGoNext: stackView.push(greenRect)
    }
    Rectangle{
        id:yellowRect
        color:"yellow"
    }
    Rectangle{
        id:greenRect
        color:"green"
    }

}
*/


