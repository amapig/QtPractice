import QtQuick 2.0
//import "CMOS_ListView_JS.js" as jsContext



ListView{
    id:listView

    ////////for js
    property QtObject jsContext:QtObject{
        id:jsObject

        property var dataArray:[]
        function createArray(size) {
            dataArray = new Array(size)
            resetValue(false)
        }

        function resetValue(value) //reset as value
        {
            console.log("resetValue",value)
            for(var i =0;i< dataArray.length;i++)
            {
                dataArray[i] = value;
            }
        }

        function checkAll(mode) { //true:check false:uncheck
            if(mode == true)
            {
                resetValue(true)
            }
            else
            {
                resetValue(false)
            }
        }

        function checkOne(index,mode)
        {
            dataArray[index] = mode
        }

        function getCheck(index)
        {
            console.log("getCheck:",index,dataArray.length)
            if(index >= dataArray.length)
                return false
            return dataArray[index]
        }

        function getCheckedItems()
        {
            var checkedList = new Array()
            for(var i = 0;i<dataArray.length;i++)
            {
                if(dataArray[i])
                {
                    checkedList.push(i)
                }
            }
            console.log("getCheckedItems "+checkedList.length,":",checkedList)
            return checkedList;
        }
    }


    //for jsend
























    property bool canEdit:true
    property bool isEditMode:false
    property bool isSelectAll:false


    signal deleteItems(variant indexList)
    signal goTop()
    signal curDragItemChanged(int curIndex)
    signal curChoiceItemChanged(int curIndex)
    signal resetDelegateState()
    clip:true
    onIsSelectAllChanged: console.log("onIsSelectAllChanged:",isSelectAll)

    function changeEditMode() //delegate access by ListView.view.changeEditMode
    {
        if(canEdit)
            isEditMode = !isEditMode
    }
    function checkItem(index,checked)
    {
        console.log("checkItem  ",index,checked)
        jsContext.checkOne(index,checked)
        if(!checked && isSelectAll)
            isSelectAll = false
    }
    function deleteTaggedItems()
    {
        var indexList = jsContext.getCheckedItems()
        jsContext.resetValue(false)
        deleteItems(indexList)
    }

    function toTop()
    {
        currentIndex=count>0?0:-1
        contentX = -leftMargin
        contentY = -topMargin
        goTop()
    }
    function getTaggedIems()
    {
        var indexList = jsContext.getCheckedItems()
        console.log("getTaggedIems",indexList)
        return indexList
    }

    function getNewStatus(index)
    {
        if(index < 0 || index >= count)
            return 0

        console.log("getNewStatus index:",index,count,jsContext.getCheck(index),index)
        return jsContext.getCheck(index)
    }

    property Item headerEditBarItem:headerEditToolBarLd.item
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
                jsContext.checkAll(!listView.isSelectAll)
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
        asynchronous: true
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
        asynchronous: true
    }
    //anchors.fill: parent
    implicitHeight: bottomEditToolBarLd.height+headerEditToolBarLd.height+130
    implicitWidth: parent.width
    topMargin: headerEditToolBarLd.height
    leftMargin: 40
    rightMargin: 40
    bottomMargin: bottomEditToolBarLd.height

//    model:myModel
//    delegate:listDelegate

    onCountChanged: {
        console.log("onCountChanged:",count)
        isEditMode = false
        jsContext.createArray(count)
    }
}

