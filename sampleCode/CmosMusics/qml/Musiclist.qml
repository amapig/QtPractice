import QtQuick 2.0
import com.nokia.meego 2.0

Page {
    id:musiclistPage
    anchors.fill: parent

    property string lable: ""

    Component.onCompleted: {
        console.log("musiclist loaded:");
    }

    function pushQml(file) {
            var component = Qt.createComponent(file)
            if (component.status == Component.Ready)
                pageStack.push(component);
            else
                console.log("Error loading component:", component.errorString());
    }

    Component {
        id: fileDelegate

        Rectangle{
            height: 150
            width: parent.width

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log("music is clicked, ready to play:" + index);
                    if(playQueue.currentIndex != index)
                    {
                        //TODO:playQueue should be only used to offer data to qml view.
                        //the operations on index must be integrated into player.
                        //playQueue.setCurrentIndex(index);
                        //player.play();
                        player.playIndex(index);
                    }
                    pushQml("Playing.qml");
                }
            }

            Row{
                spacing: 15
                height:parent.height
                width: parent.width
                anchors.left: parent.left

                Image{
                    id:icon
                    height: parent.height
                    width:height
                    source: "qrc:/image/image/nocover.png"
                    //cover
                    //:"qrc:/image/image/apple.png"
                    fillMode: Image.PreserveAspectCrop
                }
                Column{
                    id:metaID
                    Text {
                        text: name
                        font.pointSize: 32
                        font.bold: false
                        height: icon.height*3/5

                        elide:Text.ElideRight
                        verticalAlignment: Text.AlignVCenter

                    }
                    Text {
                        text: artist
                        font.pointSize: 26
                        font.bold: false
                        height: icon.height*2/5

                        elide:Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                }


            }
        }
    }

    Component {
        id: highlight

        Rectangle {
            anchors.fill: parent
            //height: 70
            //width: parent.width
            color: "lightsteelblue"
            radius: 5            
        }
    }

    ListView{
        model: playQueue
        delegate: fileDelegate
        currentIndex: playQueue.currentIndex
        anchors.top: titlebar.bottom
        anchors.topMargin: 2
        anchors.bottom: panel.top
        anchors.bottomMargin: 2
        anchors.left: parent.left
        anchors.right: parent.right
        id:muisclistview
        //focus:true
        highlight: highlight
        //height: parent.height*4/5
        highlightFollowsCurrentItem: true
        //header: titlebar
    }


    Titlebar{
        id:titlebar
        width:parent.width
        height:musiclistPage.height/10
        color: "yellow"
        anchors.top: parent.top;
        anchors.left: parent.left
        onBacksig: {
            console.log("stack pop musiclist");
            pageStack.pop();
        }
        onMenusig: {
            console.log("menu pressed, pop a menu");
        }
    }



    InfoPlayerPanel{
        id:panel
        albumurl:""
        height: parent.height/5
        anchors.bottom: parent.bottom
        width:parent.width
    }
}
