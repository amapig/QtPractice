import QtQuick 2.0

Item{
    id:toolBarItem

    signal playButtonClicked()
    signal stopButtonClicked()
    signal pauseButtonClicked()

    Rectangle{
        id: buttonContainer
        anchors.fill: parent
        color: "white"
        ToolBarButton{
                    id:playButton
                    x:buttonContainer.x+10; y:buttonContainer.y+10
                    width: (buttonContainer.width-40)/3; height: buttonContainer.height-20
                    buttonColor: "cyan"
                    buttonText: "Play Video"
                    onButtonClicked: toolBarItem.playButtonClicked()
                }

       ToolBarButton{
                    id:pauseButton
                    x:playButton.x+playButton.width+10; y:playButton.y
                    width: playButton.width; height: playButton.height
                    buttonColor: "cyan"
                    buttonText: "Pause Video"
                    onButtonClicked: toolBarItem.pauseButtonClicked()
                }
       ToolBarButton{
           id:stopButton
           x:playButton.x+2*playButton.width+20; y:playButton.y
           width: playButton.width; height: playButton.height
           buttonColor: "cyan"
           buttonText: "Exit"
           onButtonClicked: toolBarItem.stopButtonClicked()

       }

    }

}
