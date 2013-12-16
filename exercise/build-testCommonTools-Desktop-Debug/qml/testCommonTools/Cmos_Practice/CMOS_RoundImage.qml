import QtQuick 2.0
import QtQuick.Controls 1.0


Canvas{
    id:canvas
    property string imgUrl:"images/canvas.png"
    property int lineWidth:2
    width:200
    height:200
    onImageLoaded: {
        requestPaint()
    }
    onPaint: {
        if(!context)
            getContext('2d')
        if(context)
        {
            var radius = Math.min(width,height)/2
            context.beginPath();
            context.arc(width/2,height/2,radius,0,Math.PI*2,true); // Outer circle
            context.lineWidth = lineWidth
            context.stroke();
            context.clip()
            context.drawImage(imgUrl,width/2-radius,height/2-radius,radius*2,radius*2)
        }
    }

}
