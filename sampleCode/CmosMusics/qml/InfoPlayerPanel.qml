import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id: rectangle1
    //width: parent.width
    property string albumurl: ""

    function formatTime(t) {
        t = t / 1000;
        var secs = Math.floor(t % 60);
        t = t / 60;
        var mins = Math.floor(t);
        if (secs < 10) secs = "0" + secs;
        return mins + ":" + secs;
    }

    BorderImage {
        id: borderimage1
        anchors.fill: parent

        source: "qrc:/image/image/panel.png"
        border.left: 4
        border.top: 4
        border.right: 4
        border.bottom: 4

        horizontalTileMode: BorderImage.Stretch
        verticalTileMode: BorderImage.Stretch

        TimeBar {
            id: progressbar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 10
            height: parent.height/4
        }

        Item {
            id: rowlay
            //anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: progressbar.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            //spacing: 20

            ImageButton {
                id: albumimg
                anchors.left: parent.left
                anchors.top: parent.top
                width: parent.height
                height: parent.height
                //anchors.verticalCenter: parent.verticalCenter
                source1: "qrc:/image/image/apple.png"
                source2: "qrc:/image/image/apple.png"
            }

            Column {
                id: column
                anchors.left: albumimg.right
                anchors.top: parent.top
                width: (parent.width - albumimg.width)/3
                height: parent.height
                spacing: 0
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id: songname
                    anchors.left: column.left
                    anchors.leftMargin: 10
                    anchors.right: column.right
                    //anchors.top: parent.top
                    width: column.width
                    height: column.height/2
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft //player.uri
                    font.pixelSize: 20
                    text: player.title
                }

                Text {
                    id: artist
                    anchors.left: column.left
                    anchors.leftMargin: 10
                    anchors.right: column.right
                    //anchors.top: parent.top
                    width: column.width
                    height: column.height/2
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft //player.uri
                    font.pixelSize: 20
                    text: player.artist
                }
            }

            Row {
                id: ctlpanel
                height: parent.height
                spacing: 0

                anchors.left: column.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.verticalCenter: parent.verticalCenter
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                ImageButton {
                    id: previous
                    width:parent.width/3
                    height: parent.height
                    source1: "qrc:/image/image/previous_1.png"
                    source2: "qrc:/image/image/previous_2.png"
                    onClicked: {
                        playQueue.previous();
                    }
                }

                ImageButton {
                    id: paypause
                    width:parent.width/3
                    height: parent.height
                    source1: player.isPlaying? "qrc:/image/image/pause_1.png" : "qrc:/image/image/play_1.png"
                    source2: player.isPlaying? "qrc:/image/image/pause_2.png" : "qrc:/image/image/play_2.png"
                    onClicked: {
                        player.isPlaying?player.pause():player.play();
                    }
                }

                ImageButton {
                    id: next
                    width:parent.width/3
                    height: parent.height
                    source1: "qrc:/image/image/next_1.png"
                    source2: "qrc:/image/image/next_2.png"
                    onClicked: {
                        playQueue.next();
                    }
                }
            }
        }

    }
}
