import QtQuick 2.0

CMOS_BasicDelegate {
    id:gvDelegate
    property bool useParentLayout:false
    isTagged: useParentLayout?parent.GridView.view.jsContext.getCheck(index):GridView.view.jsContext.getCheck(index)
    onIsTaggedChanged: {
        if(useParentLayout)
        {
            parent.GridView.view.jsContext.checkOne(index,isTagged)
            if(!isTagged)
                parent.GridView.view.isSelectAll = false
        }
        else
        {
            GridView.view.jsContext.checkOne(index,isTagged)
            if(!isTagged)
                GridView.view.isSelectAll = false
        }
    }
    Binding{
        target:gvDelegate
        property:"isEditing"
        value:useParentLayout?gvDelegate.parent.GridView.view.isEditing:gvDelegate.GridView.view.isEditing
    }

    onPressAndHold: {
        if(canEdit)
        {
            if(useParentLayout)
            {
                parent.GridView.view.changeEditMode()
            }
            else
            {
                GridView.view.changeEditMode()
            }
        }
    }

    Connections{
        target:gvDelegate.GridView.view
        onSelectAll:gvDelegate.isTagged = selected
    }
    Component.onCompleted: console.log("item created!!!!!!!!!!!!!!",index)
}
