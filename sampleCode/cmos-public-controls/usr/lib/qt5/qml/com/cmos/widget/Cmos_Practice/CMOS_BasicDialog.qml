import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    id:rootItem
    implicitWidth :parent.width
    implicitHeight:parent.height
    opacity:1
    z:100

    property Item background:backgroundLd.item
    property Component backgroundCmp:Rectangle{
        opacity: 0.73
        color:"black"
    }

    signal cancel()



    Component.onCompleted: {
        parent = findRoot()
        console.log("Component.onCompleted",parent.width,parent.height,width,height)
    }
    onVisibleChanged: {
        console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ onVisibleChanged")
        parent = findRoot()

    }
    onParentChanged: {
        width = parent.width
        height = parent.height
        console.log("onParentChanged:",parent.width,parent.height,parent.toString())
    }

    function findRoot()
    {
        if(!parent||!parent.parent)
            return parent
        var root = rootItem.parent
        while(root.parent && root.parent.parent)
        {
            root = root.parent
        }
        console.log("CMOS_PopupMenu:findRoot:",root.width,root.height)
        return root
    }

    MouseArea
    {
        id:mouseArea
        anchors.fill: parent
        onClicked: {
            parent.visible = false
            rootItem.cancel()
       }
    }

//    property int contentAlignTag : 0 //top:right:bottom:left
//    property int leftAlignOffset:0
//    property int rightAlignOffset:0
//    property int topAlignOffset:0
//    property int bottomAlignOffset:0
//    property int contentMenuX:0
//    property int contentMenuY:0

    property Item contentLabel: contentLabelLd.item
    property Component contentLabelCmp:null

    Loader{
        id:backgroundLd
        anchors.fill: parent
        sourceComponent: backgroundCmp

        Loader{
            z:parent.z+1
            id:contentLabelLd
            sourceComponent: contentLabelCmp
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            MouseArea{
                anchors.fill: parent
            }
        }

    }


}
