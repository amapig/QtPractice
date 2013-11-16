import QtQuick 2.0
import Qt 4.7

Rectangle {
    id: mainRect
    width: 360
    height: 640
    color: "black"

    TopTitleBar{
        id:topTopTitleBar
        x:mainRect.x; y:mainRect.y
        width: mainRect.width; height: mainRect.height/20+10
    }

    Rectangle{
        id:videoRect
        x:mainRect.x; y:topTopTitleBar.y+topTopTitleBar.height
        width: mainRect.width; height: mainRect.height-topTopTitleBar.height-70
        color: "black"

        Loader{
            id:videoLoader
            anchors.fill: videoRect
        }

    }

    /*
      Simple Toolbar Item which has play, pause and stop button
      */

    ToolBar{
        id:toolBar
        x: videoRect.x; y:topTopTitleBar.y+topTopTitleBar.height+videoRect.height;
        width: videoRect.width; height: mainRect.height-videoRect.height-topTopTitleBar.height

        onPlayButtonClicked: {
            console.log("Play Button Clicked")
            videoLoader.source = "VideoPlayer.qml" // sets the Loader to load our VideoPlayer Component
            videoLoader.item.playVideo()// starts the video
        }
        onStopButtonClicked: {
                console.log("Video Stopped"+videoLoader.source)
                videoLoader.item.stopVideo() // stops the video
                videoLoader.source = "" // unloads the QML Video Element component
                Qt.quit() // exits the application
        }

        onPauseButtonClicked: {
                console.log("Pause Suceessful"+videoLoader.source)
                videoLoader.item.pauseVideo()// pause the video
        }

     }
}
