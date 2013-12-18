import QtQuick 2.0
//sin@ = y/Radius  =radius*sin@
//cos@=x/radius  =>x=radius*cos@
//l=|a|R
//tan@ = y/x
//ctan@= x/y
Canvas{
    implicitHeight: 100
    implicitWidth: 100

    renderStrategy: Canvas.Immediate
    renderTarget: Canvas.Image
    property int lineWidth:2
    property int circleWidth:20

    property real sliderValue: 0

    property variant fillStyle:"blue"
    property variant strokeStyle:"green"
    property variant backStyle:"black"

    property real maxValue:100
    property real minValue:0
    property int value:10
    property real stepSize: 1

    property bool canSlider:false

    property real centerX:Math.min(width,height)/2
    property real centerY:Math.min(width,height)/2
    property real outRadius:Math.min(width,height)/2- lineWidth*2
    property real inRadius:outRadius-circleWidth
    property real sliderRadius:(outRadius+inRadius)/2

    property bool antiClockwise:true

    property bool __valueChangedInner:false


    function isPointValid(posX,posY)
    {
        var curRadius =  Math.sqrt(Math.pow(posX-centerX,2)+Math.pow(posY-centerY,2))
        if(curRadius >= inRadius && curRadius <= outRadius)
        {
            return true
        }
        else
            return false
    }

    function toPosition(posX,posY)
    {
        if(canSlider && isPointValid(posX,posY))
        {

            __valueChangedInner = true
            if(posX-centerX == 0)
            {
                if(posY-centerY >= 0)
                {
                    sliderValue = Math.PI/2
                }
                else
                {
                    sliderValue = Math.PI*1.5
                }
            }
            //console.log("position changed:",Math.tan(90),sliderValue)

            var disX = posX-centerX
            var disY = posY-centerY
            if(disX > 0)
            {
                if(disY >= 0)
                    sliderValue = Math.atan(disY/disX) //1
                else
                    sliderValue = Math.atan(disY/disX)+Math.PI*2 //4
            }
            else if(disX < 0)
            {
//                if(disY >= 0)
//                    sliderValue = Math.atan(disY/disX) +Math.PI
//                else
//                    sliderValue = Math.atan(disY/disX) +Math.PI
                sliderValue = Math.atan(disY/disX) +Math.PI
            }
            //requestPaint()

        }
        else
            canSlider = false

    }

    onSliderValueChanged: {

        handleImg.x = Math.cos(sliderValue)*sliderRadius+centerX-handleImg.width/2-lineWidth
        handleImg.y = Math.sin(sliderValue)*sliderRadius+centerY-handleImg.height/2-lineWidth
        console.log("onSliderValueChanged11  ",sliderValue,Math.cos(sliderValue),Math.sin(sliderValue))
        requestPaint()
        if(__valueChangedInner)
        {
            if(!antiClockwise)
                 value = sliderValue/(Math.PI*2)*(maxValue-minValue)
            else
                value = (Math.PI*2 - sliderValue)/(Math.PI*2)*(maxValue-minValue)
        }
        console.log("onSliderValueChanged @@@@@@@@@@@@@@@")

    }

    onValueChanged: {
        console.log("onValueChanged @@@@@@@@@@@@@@@",value)
        if(!__valueChangedInner)
        {
            if(!antiClockwise)
                sliderValue = value/(maxValue-minValue)*Math.PI*2
            else
                sliderValue = Math.PI*2 - value/(maxValue-minValue)*Math.PI*2
        }
        __valueChangedInner = false
    }



    Image{
        id:handleImg
        width: circleWidth-2*lineWidth
        height: width
        source:"images/handleimg.png"
        fillMode:Image.Stretch
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {console.log(mouseX,mouseY,Math.sqrt(Math.pow(mouseX-centerX,2)+Math.pow(mouseY-centerY,2)),inRadius,outRadius)

        }
        onPressed: {
            canSlider = parent.isPointValid(mouse.x,mouse.y)
        }
        onReleased: {
            toPosition(mouseX,mouseY)
        }
        onPositionChanged: {
            toPosition(mouseX,mouseY)
//            if(canSlider && isPointValid(mouse.x,mouse.y))
//            {


//                if(mouse.x-centerX == 0)
//                {
//                    if(mouse.y-centerY >= 0)
//                    {
//                        sliderValue = Math.PI/2
//                    }
//                    else
//                    {
//                        sliderValue = Math.PI*1.5
//                    }
//                }
//                //console.log("position changed:",Math.tan(90),sliderValue)
//                parent.requestPaint()
//                var disX = mouse.x-centerX
//                var disY = mouse.y-centerY
//                if(disX > 0)
//                {
//                    if(disY >= 0)
//                        sliderValue = Math.atan(disY/disX) //1
//                    else
//                        sliderValue = Math.atan(disY/disX)+Math.PI*2 //4
//                }
//                else if(disX < 0)
//                {
//                    if(disY >= 0)
//                        sliderValue = Math.atan((mouse.y-centerY)/(mouse.x-centerX)) +Math.PI
//                    else
//                        sliderValue = Math.atan((mouse.y-centerY)/(mouse.x-centerX)) +Math.PI
//                }
//            }
//            else
//                canSlider = false

        }

    }
    Timer{
        running: false
        interval: 500
        repeat: true
        onTriggered:
        {
            console.log("onTriggered")
            if(parent.value < parent.maxValue)
            parent.value += parent.stepSize

        }
    }
    onPaint: {
        //console.log("onPaint region:",region.x,region.y,region.width,region.height)

        centerX = region.width/2
        centerY = region.height/2

        outRadius = Math.min(region.width,region.height)/2- lineWidth*2
        inRadius = outRadius-circleWidth
        sliderRadius = (outRadius+inRadius)/2
        var sliderLineWidth = outRadius - inRadius-lineWidth*2

        if(!context)
            getContext("2d")

        if(context)
        {

            context.fillStyle = backStyle //"#ccddee"
            context.strokeStyle = strokeStyle
            context.fillRule = Qt.OddEvenFill
            context.beginPath();
            context.arc(width/2-2,height/2-2,outRadius,0,Math.PI*2,true); // Outer circle

            context.arc(width/2-2,height/2-2,inRadius,0,Math.PI*2,true); // Outer circle
            context.closePath();
            context.fill();


            context.beginPath();
            context.arc(width/2-2,height/2-2,sliderRadius,0,sliderValue,antiClockwise); // Outer circle
            context.lineWidth = sliderLineWidth
            context.strokeStyle = fillStyle
            context.stroke();
        }
    }

    Component.onCompleted:
    {
        handleImg.x = sliderRadius+centerX-handleImg.width/2-lineWidth
        handleImg.y = centerY-handleImg.width/2-lineWidth
        if(!antiClockwise)
            sliderValue = value/(maxValue-minValue)*Math.PI*2
        else
            sliderValue = Math.PI*2 - value/(maxValue-minValue)*Math.PI*2
    }



}
