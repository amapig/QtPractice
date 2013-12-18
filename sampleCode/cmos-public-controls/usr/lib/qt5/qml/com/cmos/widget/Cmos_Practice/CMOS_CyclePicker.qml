import QtQuick 2.0
import QtQuick.Controls 1.0
import com.cmos.widget 1.0
PathView{
    id:cyclePicker
    UIConst{
        id: constUi
    }
    property int  factor: constUi.getValue("factor")

    property var values:[0,1,2,3]
    property int fontSize:30 * factor
    property color fontColor:"black"
    property int borderWidth: 1
    property color borderColor:"green"
    property color backgroundColor:"grey"
    property int radius:4

    property int minValue: 0 //1:spin mode
    property int maxValue: 9 //1:spin mode
    property real stepSize: 1 //1:spin mode

    property int valueMode:0  //0:values mode   1:spin mode

    property Item backgroundItem: backgroundLd.item //created by background component
    property Component background:Component{
        Rectangle{
            color:cyclePicker.backgroundColor
            border.width: cyclePicker.borderWidth
            border.color: cyclePicker.borderColor
            radius:cyclePicker.radius
        }
    }
    function getCurValue()
    {
        if(currentIndex >= 0 && currentIndex < values.length)
            return values[currentIndex]
    }
    function __initModel()
    {
        if(valueMode == 1) //spin Mode
        {
            console.log("222222222222222222222",values.length)
            values.splice(0,values.length)
            console.log("1111111111111111111111",values.length)
            var minVal = Math.min(minValue,maxValue)
            var maxVal = Math.max(minValue,maxValue)
            var  i = 0
            for(i = minVal;i<=maxVal;(i+=stepSize))
            {
                model.append({"value":i})
                values.push(i)
            }
            if(i-stepSize < maxVal)
            {
                values.push(maxVal)
                model.append({"value":maxVal})
            }
        }
        else
        {
            for(var j = 0;j<values.length;j++)
            {
                model.append({"value":values[j]})
            }
        }
        console.log("__initModel",values.length)
    }

    implicitHeight: 130
    implicitWidth: parent.width
    clip:true

    preferredHighlightBegin : 0.5
    preferredHighlightEnd : 0.5

    Loader{
        id:backgroundLd
        anchors.fill: parent
        sourceComponent: background
    }
    model:ListModel{
    }

    delegate:Label{
        height:130
        width:height
        text:model.value
        font.pointSize: cyclePicker.fontSize
        color:index == PathView.view.currentIndex?cyclePicker.fontColor:"white"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }

    highlightRangeMode:ListView.StrictlyEnforceRange
    Component.onCompleted: {
        cyclePicker.__initModel()
        if(count > 0)currentIndex = 0
    }
    pathItemCount:height/130
    path: Path {
        startX: width/2; startY: 0
        PathLine { x: width/2; y:  height;}
    }

    highlight: Rectangle{
        implicitWidth: currentItem?currentItem.width:0
        implicitHeight: currentItem?currentItem.height:0
        radius:currentItem?Math.min(width,height)/2:0
        color:"green"
    }

}
