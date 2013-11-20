/* This file is part of Music Shelf
 * Copyright (C) 2011 Martin Grimme  <martin.grimme _AT_ gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */


import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    property bool portrait: true
    property string srcUri: ""


    id: bar
    color: "black"

    BorderImage {
        anchors.fill: parent

        source: "qrc:/image/image/panel.png"
        border.left: 4
        border.top: 4
        border.right: 4
        border.bottom: 4


        TimeBar {
            id: progressBox
            width: bar.width
            height: bar.height/4
            anchors.left: parent.left
            anchors.top: parent.top
        }

        Row {
            id: rowbtn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: progressBox.bottom
            anchors.topMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            spacing: 0//(rowbtn.width - prevBtn.width*3)/2
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            Component.onCompleted: {
                console.log("Row.width="+rowbtn.width+" Row.height="+rowbtn.height+"ImgBtn.width="
                            +prevBtn.width+"spacing="+rowbtn.spacing);
            }

            ImageButton {
                id:prevBtn
                width:parent.width/3
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                source1: "qrc:/image/image/previous_1.png"
                source2: "qrc:/image/image/previous_2.png"
                onClicked: {
                    player.previous();
                    //playQueue.previous();
                }
            }
            ImageButton {
                width:parent.width/3
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                source1: player.isPlaying? "qrc:/image/image/pause_1.png" : "qrc:/image/image/play_1.png"
                source2: player.isPlaying? "qrc:/image/image/pause_2.png" : "qrc:/image/image/play_2.png"
                onClicked: {
                    player.isPlaying?player.pause():player.play();
                }
            }
            ImageButton {
                width:parent.width/3
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                source1: "qrc:/image/image/next_1.png"
                source2: "qrc:/image/image/next_2.png"
                onClicked: {
                    player.next();
                    //playQueue.next();
                }
            }
        }

    }
}
