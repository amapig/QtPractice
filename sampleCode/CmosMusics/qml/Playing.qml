import QtQuick 2.0
import com.nokia.meego 2.0

Page {
    id:playing
    anchors.fill:parent

    function getCoverPath()
    {
        var imgpath = playQueue.getImgPath(playQueue.currentIndex);
        if(imgpath == "")
            return "qrc:/image/image/playing_bg.png"
        else
        {
            var ret = "file://"+imgpath
            console.log("cover path:"+ret);
            return ret;
        }
    }

    Titlebar{
        id:titlebar
        width:parent.width
        height:parent.height/10
        color: "blue"
        title: player.name
        anchors.top: parent.top;
        anchors.left: parent.left
        onBacksig: {
            console.log("stack pop playing");
            pageStack.pop();
        }
        onMenusig: {
            console.log("menu pressed, pop a menu");
        }
    }

    Image{
        id:bg
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titlebar.bottom
        anchors.bottom: playctl.top
        source: getCoverPath()
        //"qrc:/image/image/playing_bg.png"
        fillMode:Image.PreserveAspectCrop
        horizontalAlignment:Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
    }

    PlayerControls{
        id:playctl
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height/5
    }
}
