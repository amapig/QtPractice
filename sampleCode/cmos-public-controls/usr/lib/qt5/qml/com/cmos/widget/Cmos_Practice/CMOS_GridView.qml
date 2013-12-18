import QtQuick 2.0

GridView{

    id:gridview
    property alias jsContext:jsObject
    property alias editBar:editTopBar
    property alias toolBar:bottomToolBar
    property bool enableEditBar:true
    property bool enableToolBar:true

    topMargin:editBar.visible?editBar.height:0
    bottomMargin: toolBar.visible?toolBar.height:0
    QtObject{
        id:jsObject

        property var dataArray:[]
        function createArray(size) {
            if(size == dataArray.length)
                return
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
            return dataArray[index]==undefined?false:dataArray[index]
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


    property bool isExclusive:false
    property bool canEdit:true
    property bool isEditing:false
    property bool isSelectAll:false
    signal selectAll(bool selected)
    signal toolBarTrigger(int index)
    signal deleteItems(variant indexList)


    function changeEditMode()
    {
        if(canEdit)
        {
            isEditing = !isEditing
        }
    }

    onToolBarTrigger:{
        if(index == 0)
        {
            deleteItems(jsContext.getCheckedItems())
        }
    }


    CMOS_EditTitleBar{
        id:editTopBar
        width:parent.width
        rightText:gridview.isSelectAll?"取消全选":"全选"
        visible:gridview.enableEditBar&&gridview.isEditing
        onLTrigger: {
            gridview.changeEditMode()
            gridview.isSelectAll = false
            gridview.selectAll(gridview.isSelectAll)
        }
        onRTrigger: {
            console.log("listView.isSelectAll != listView.isSelectAll",gridview.isSelectAll)
            gridview.isSelectAll = !gridview.isSelectAll
            gridview.jsContext.checkAll(gridview.isSelectAll)
            gridview.selectAll(gridview.isSelectAll)
        }
    }


    ListModel{
        id:myToolBarModel
        ListElement{
            imgUrl:"images/bn1.png"
            title:"删除"
        }
    }

    CMOS_ToolBar{
        id:bottomToolBar
        width:parent.width
        bMargin: 0
        visible:gridview.enableToolBar&&gridview.isEditing
        repeatModel: myToolBarModel
        spacing:bottomToolBar.spacing
        onTrigger:
        {
            gridview.toolBarTrigger(index)
        }

    }

    onCountChanged: {
        console.log("onCountChanged:",count)
        //isEditing = false
        isSelectAll = false
        jsContext.createArray(count)
        selectAll(false)
    }

}
