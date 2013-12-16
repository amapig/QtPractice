import QtQuick 2.0
import "CMOS_ListView_JS.js" as JsContext



ListView{
    id:listView
    property bool canEdit:true
    property bool isEditMode:false
    property bool isSelectAll:false

    signal deleteItems(variant indexList)
    signal goTop()
    signal curDragItemChanged(int curIndex)
    signal resetDelegateState()

    onIsSelectAllChanged: console.log("onIsSelectAllChanged:",isSelectAll)

    function changeEditMode() //delegate access by ListView.view.changeEditMode
    {
        if(canEdit)
            isEditMode = !isEditMode
    }
    function checkItem(index,checked)
    {
        console.log("checkItem  ",index,checked)

        JsContext.checkOne(index,checked)
        if(!checked && isSelectAll)
            isSelectAll = false
    }
    function deleteTaggedItems()
    {
        var indexList = JsContext.getCheckedItems()
        JsContext.resetValue(false)
        deleteItems(indexList)
    }

    function toTop()
    {
        currentIndex=count>0?0:-1
        contentX = -leftMargin
        contentY = -topMargin
        goTop()
    }

    function getNewStatus(index)
    {
        if(index < 0)
            return

        console.log("getNewStatus index:",JsContext.getCheck(index),index)
        return JsContext.getCheck(index)
    }


    property Component headerEditBarCmp:headerEditBarComponent

    Component{
        id:headerEditBarComponent
        CMOS_EditTitleBar{
            id:editTopBar
            width:parent.width
            rightText:listView.isSelectAll?"取消全选":"全选"
            visible:listView.isEditMode
            onLTrigger: {
                listView.changeEditMode()
            }
            onRTrigger: {
                console.log("listView.isSelectAll != listView.isSelectAll",listView.isSelectAll)
                JsContext.checkAll(!listView.isSelectAll)
                listView.isSelectAll = !listView.isSelectAll
            }
        }
    }
    Loader{
        id:headerEditToolBarLd
        sourceComponent: listView.headerEditBarCmp
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
    }
    property Component bottomEditToolBarCmp:bottomEditToolBarComponent
    property int toolBarSpacing:118
    property ListModel toolBarModel:myToolBarModel
    signal toolBarTrigger(int index)
    onToolBarTrigger: {
        console.log("CMOS_ToolBar is trigger:",index,currentIndex)
        if(toolBarModel === myToolBarModel)
        {
            if(index == 0)//to top
            {
                listView.toTop()
            }
            else if(index == 1) //delete
            {
                listView.deleteTaggedItems();
            }
        }
    }
    ListModel{
        id:myToolBarModel
        ListElement{
            imgUrl:"images/bn1.png"
            title:"置顶"

        }
        ListElement{
            imgUrl:"images/bn1.png"
            title:"删除"
        }
    }
    Component{
        id:bottomEditToolBarComponent
        CMOS_ToolBar{
            id:bottomToolBar
            width:parent.width
            bMargin: 0
            visible:listView.isEditMode
            repeatModel: listView.toolBarModel
            spacing:listView.toolBarSpacing
            onTrigger:
            {
                listView.toolBarTrigger(index)
            }

        }
    }

    Loader{
        id:bottomEditToolBarLd
        sourceComponent: listView.bottomEditToolBarCmp
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom:parent.bottom
    }
    anchors.fill: parent
    topMargin: headerEditToolBarLd.height
    leftMargin: 40
    rightMargin: 40
    bottomMargin: bottomEditToolBarLd.height

//    model:myModel
//    delegate:listDelegate

    onCountChanged: {
        console.log("onCountChanged:",count)
        isEditMode = false
        JsContext.createArray(count)
    }
}

