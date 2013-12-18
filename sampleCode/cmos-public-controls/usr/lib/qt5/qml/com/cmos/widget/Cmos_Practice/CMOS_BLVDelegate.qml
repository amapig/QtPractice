import QtQuick 2.0

CMOS_BasicDelegate {
    id:blvDelegate
    isTagged: ListView.view.jsContext.getCheck(index)
    onIsTaggedChanged: {

        ListView.view.jsContext.checkOne(index,isTagged)
        if(!isTagged)
            ListView.view.isSelectAll = false

    }
    Binding{
        target:blvDelegate
        property:"isEditing"
        value:blvDelegate.ListView.view.isEditing
    }

    onPressAndHold: {
        if(canEdit)
        {
             ListView.view.changeEditMode()
        }
    }

    Connections{
        target:blvDelegate.ListView.view
        onSelectAll:blvDelegate.isTagged = selected
    }
    onDeleteItem: ListView.view.deleteItem(index)
    Component.onCompleted: console.log("blvDelegate item created!!!!!!!!!!!!!!",index)
}
