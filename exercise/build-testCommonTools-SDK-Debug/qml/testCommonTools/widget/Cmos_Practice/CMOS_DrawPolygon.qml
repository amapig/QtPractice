import QtQuick 2.0

Canvas{
    id:myCanvas
    property int bgFillMode:1 //0: bgColor 1:gradientArray
    property bool isFillMode:false
    property string bgColor: "red"
    property variant polygonPoints:[Qt.point(0,0),Qt.point(width,0),Qt.point(width,height),Qt.point(50,height),Qt.point(50,50)]
    property variant gradientArray:[[0.2,"red"],[0.5,"green"],[1,"blue"]]
    property int gradientMode:1 //0:line Graident 1:Radial Graident 2:Conica Graident
    property int lineWidth:2
    onPaint: {
        if(! context)
            getContext('2d')
        if(context)
        {


            context.lineWidth = lineWidth
            context.beginPath()

            for(var i = 0;i<polygonPoints.length;i++)
            {
                console.log("point i:",i,polygonPoints[i].x,polygonPoints[i].y)
                if(i == 0)
                    context.moveTo(polygonPoints[i].x,polygonPoints[i].y)
                else{
                    context.lineTo(polygonPoints[i].x,polygonPoints[i].y)
                }
            }
            context.lineTo(polygonPoints[0].x,polygonPoints[0].y)
            //context.closePath()


            if(isFillMode)
            {

                if(bgFillMode == 0)
                    context.fillStyle = bgColor
                else
                {
                    var gradient
                    if(gradientMode == 0)
                    {
                        gradient = context.createLinearGradient(0, 0, width,width);

                    }
                    else if(gradientMode == 1)
                    {
                        console.log("fdsfdf")
                        gradient = context.createConicalGradient(width/2,height/2,-90)
                    }
                    else if(gradientMode == 2)
                    {
                        gradient = context.createRadialGradient(width/2,height/2,0,width/2,height/2,Math.max(width,height))
                    }

                    for(var j = 0;j<gradientArray.length;j++)
                    {
                        if(gradient)
                            gradient.addColorStop(gradientArray[j][0], gradientArray[j][1]);
                    }
                    context.fillStyle=gradient
                    context.strokeStyle = gradient
                }
                context.fill()
            }
            else
                context.stroke()
        }
    }
}
