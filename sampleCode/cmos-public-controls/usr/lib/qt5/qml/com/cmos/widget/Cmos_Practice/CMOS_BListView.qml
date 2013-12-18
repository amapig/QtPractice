import QtQuick 2.0

ListView{

    id:listview
    //property alias jsContext:jsObject
    property alias editBar:editTopBar
    property alias toolBar:bottomToolBar
    property bool enableEditBar:true
    property bool enableToolBar:true

    readonly property QtObject jsContext:jsObject

    topMargin:editBar.visible?editBar.height:0
    bottomMargin: toolBar.visible?toolBar.height:0

    CMOS_JSForEdit{
        id:jsObject
    }


    property bool isExclusive:false
    property bool canEdit:true
    property bool isEditing:false
    property bool isSelectAll:false
    signal selectAll(bool selected)
    signal toolBarTrigger(int index)
    signal deleteItems(variant indexList)
    signal deleteItem(int index)

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
        rightText:listview.isSelectAll?"取消全选":"全选"
        visible:listview.enableEditBar&&listview.isEditing
        onLTrigger: {
            listview.changeEditMode()
            listview.isSelectAll = false
            listview.jsContext.checkAll(false)
            listview.selectAll(false)
        }
        onRTrigger: {
            console.log("listView.isSelectAll != listView.isSelectAll",listview.isSelectAll)
            listview.isSelectAll = !listview.isSelectAll
            listview.jsContext.checkAll(listview.isSelectAll)
            listview.selectAll(listview.isSelectAll)
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
        visible:listview.enableToolBar&&listview.isEditing
        repeatModel: myToolBarModel
        spacing:bottomToolBar.spacing
        onTrigger:
        {
            listview.toolBarTrigger(index)
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
