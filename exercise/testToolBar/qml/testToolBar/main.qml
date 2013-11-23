import QtQuick 2.0
//import QtQuick.Controls 1.0

Rectangle {
    id: mainPage
    width: 600
    height: 800

    Titlebar {
        id: filterBar
        visible: true
        width:parent.width
        height: parent.height/10
        color: "black"
        anchors.top: parent.top;
        anchors.left: parent.left
        onBacksig: {
            console.log("exit application");
            Qt.quit();
        }
        onMenusig: {
            console.log("menu pressed, pop a menu in mainpage");
        }
    }

    // search box
    Rectangle {
        id: searchBar
        width: filterBar.width
        height: filterBar.height - 20
        y: filterBar.height
        color: "gray"

        MouseArea {
            anchors.fill: parent
            onClicked: page.focus = false;
        }

        // mc: Shadow effects
        ShadowRectangle {
            color: "lightgray"
            transformOrigin: "Center"
            //opacity: 0.97
            visible: true
            // anchors.centerIn: parent
            width: parent.width
            // height: parent.height
            anchors.top: parent.top -5
            anchors.bottom: parent.bottom - 5
        }

        TextBox {
            id: search;
            visible: true
            opacity: 1
            // anchors.centerIn: parent
            width: searchBar.width - 200
            //            height: searchBar.height - 20
            anchors.top: searchBar.top - 5
            anchors.bottom: searchBar.bottom - 5
            //            anchors.right: parent.right - 100
        }
    }

    Loader { id: pageLoader }

    // mc: Button can not use.
    ImageButton {
        id: testButton
        width : 60
        height: 40
        anchors.bottom: mainPage.bottom
        Text {
            id: name
            anchors.centerIn: parent
            text: qsTr("Text")
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                pageLoader.source = "PlayingView.qml"
                testButton.destroy();
                //                pageLoader.top = parent.top
                //                pageLoader.bottom = parent.bottom
                //                x = parent.x
            }
        }
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
                        // player.playIndex(index);

                        // PlayingView.openVideo(playQueue.getPath(index));
                        console.log("1111111111111111" + playQueue.getPath(index));
                    }
                    console.log("2222222222222222" + playQueue.getPath(index));
                    pageLoader.source = "PlayingView.qml";
                    pageLoader.item.openVideo(playQueue.getPath(index));
//                    playingView.openVideo(playQueue.getPath(index));
                    // pushQml("PlayingView.qml");
                }
            }

            Row{
                //spacing: 15
                height:parent.height
                width: parent.width
                anchors.left: parent.left

                Image{
                    id:icon
                    height: parent.height
                    width:height
                    // source: "qrc:/image/image/nocover.png"
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
                        text: "artist"
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

    GridView {
        model: playQueue
        delegate: fileDelegate
        currentIndex: playQueue.currentIndex
        anchors.top: searchBar.bottom
        anchors.topMargin: 2
        //anchors.bottom: panel.top
        //anchors.bottomMargin: 2
        anchors.left: parent.left
        anchors.right: parent.right
        id:muisclistview
        //focus:true
        highlight: highlight
        //height: parent.height*4/5
        highlightFollowsCurrentItem: true
        //header: filterBar
    }

//    PlayingView {
//        id: playingView
//        anchors.top: mainPage.top
//    }

}
