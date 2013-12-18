import QtQuick 2.0

import QtQuick 2.0
import QtQuick.Controls 1.0
import com.cmos.widget 1.0
ListView{
    id:navigation
    UIConst{
        id: constUi
    }
    property int  factor: constUi.getValue("factor")

    clip:true
    property var values:["0dsfdsf","111111","dfsdsfd","333333333333"]
    property int fontSize:30 * factor
    property color fontColor:"black"
    property int borderWidth: 1
    property color borderColor:"green"
    property color backgroundColor:"grey"
    property int radius:4

    orientation:Qt.Horizontal

    signal itemClicked(int itemIndex)

    property Item backgroundItem: backgroundLd.item //created by background component
    property Component background:Component{
        Rectangle{
            color:navigation.backgroundColor
            border.width: navigation.borderWidth
            border.color: navigation.borderColor
            radius:navigation.radius
        }
    }

    function pushValue(value)
    {
        values.push(value)
        model.append({"value":value})
        currentIndex = count-1
    }

    function popValue(value)
    {
        for(var i = values.length-1;i>=0&&values[i] != value;i--)
        {

            model.remove(values.length-1,1)
            values.pop()

        }
        if(count)
            currentIndex = count-1
    }

    function clearAll()
    {
        values.splice(0,values.length)
        model.clear()
    }

    function getCurValue()
    {
        if(currentIndex >= 0 && currentIndex < values.length)
            return values[currentIndex]
    }
    function getIndexValue(index)
    {
        if(index >= 0 && index < values.length)
            return values[currentIndex]
    }



    function __initModel()
    {
        for(var j = 0;j<values.length;j++)
        {
            model.append({"value":values[j]})
        }
        console.log("__initModel",values.length)
    }


    implicitHeight: 130
    implicitWidth: parent.width

    Loader{
        id:backgroundLd
        anchors.fill: parent
        sourceComponent: background
        z:parent.z-1
    }

    model:ListModel{
    }

    delegate:Label{
        id:delegateLabel
        height:parent.height
        width:contentWidth+20
        text:model.value
        font.pointSize: navigation.fontSize
        color:navigation.fontColor
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        MouseArea{
            anchors.fill: parent
            onClicked: navigation.itemClicked(index)
        }
    }

    preferredHighlightBegin : 0.5
    preferredHighlightEnd : 0.5

    onCurrentIndexChanged: {
        console.log("onCurrentIndexChanged",currentIndex,getCurValue())
    }


    Component.onCompleted: {
        console.log("Component.onCompleted")
        navigation.__initModel()
        if(count>0)
            currentIndex = 0
    }

    highlight: Rectangle{
        implicitWidth: navigation.currentItem?navigation.currentItem.width:0
        implicitHeight: navigation.currentItem?navigation.currentItem.height:0
        radius:currentItem?Math.min(width,height)/2:0
        color:"green"
    }


}
