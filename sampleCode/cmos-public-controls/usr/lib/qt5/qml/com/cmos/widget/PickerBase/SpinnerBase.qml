/***************************************************************************
    Copyright (C) 2013 by CMOS
    Author: ZhaoDongshuang
    Email: zhaodongshuang@cmos.net
    Date: 2013-11-13
    File: SpinnerBase.qml
 ***************************************************************************/
import QtQuick 2.0

Item{
    // public:
    id: root
    width: 148; height: parent.height;
    property alias background: backgroudLoader.sourceComponent;
    property alias model: view.model;
    property int textRotation: 0;
    property int pixelSize: 65;
    property alias moving: view.moving;
    property string unitText: ""

    // public:
    function currentIndex(){ return view.currentIndex; }
    function setCurrentIndex(index){ view.currentIndex = index; }

    signal currentIndexChanged(int curIndex);

    Loader{ id: backgroudLoader; anchors.fill: parent; }

    Component {
        id: appHighlight
        Item{
            width: bgWidth < 148 ? 148 : bgWidth; height: 148;
            BorderImage {
                source: "./images/bg.png" ; anchors.fill: parent
                border { left: 70; top: 0; right: 70; bottom: 0; }
            }
            ShadowText{
                text: unitText;
                anchors { centerIn: parent; verticalCenterOffset: 50 }
            }
        }
    }

    PathView{
        id: view
        anchors.fill: parent; focus: true; clip: true; pathItemCount: 3;
        preferredHighlightBegin: 0.5; preferredHighlightEnd: 0.5;
        highlight: appHighlight

        delegate: Item{
            width: parent.width; height: parent.height; rotation: textRotation;
            Text {
                id: textArea;
                anchors.centerIn: parent; text: content;
                font.pixelSize: (index === view.currentIndex) ? pixelSize : pixelSize*10/13;
                color: (index === view.currentIndex) ? "#FFFFFF" : "#CFE1E0";
            }
            states: State {
                when: textArea.paintedWidth > 98
                PropertyChanges { target: root; bgWidth: textArea.paintedWidth + 80; }
            }
        }

        path: Path{
            startX: view.width/2; startY: 0;
            PathLine { x: view.width/2; y: view.height }
        }

        onCurrentIndexChanged: { parent.currentIndexChanged(currentIndex); }
    }

    // private:
    property real bgWidth: 148
    PropertyChanges { target: root; explicit: true; width: bgWidth; }
}
