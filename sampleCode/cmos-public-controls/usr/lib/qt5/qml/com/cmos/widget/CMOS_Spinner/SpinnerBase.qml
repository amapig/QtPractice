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
    property alias background: backgroudLoader.sourceComponent;
    property alias model: view.model;
    property int textRotation: 0;
    property int pixelSize: height*4/5;
    // private:
    property string __text: "";

    // public:
    function currentIndex(){ return view.currentIndex; }
    function currentText(){ return __text; }

    signal currentIndexChenged();

    Loader{ id: backgroudLoader; anchors.fill: parent; }

    PathView{
        id: view
        anchors.fill: parent; focus: true; clip: true; pathItemCount: 1;
        preferredHighlightBegin: 0.5; preferredHighlightEnd: 0.5;

        delegate: Item{
            width: parent.width; height: parent.height; rotation: textRotation;

            Text {
                id: textArea;
                anchors.centerIn: parent; text: content; font.pixelSize: pixelSize;
                onTextChanged: { __text = content; }
            }
        }

        path: Path{
            startX: view.width/2; startY: 0;
            PathLine { x: view.width/2; y: view.height }
        }

        onCurrentIndexChanged: { parent.currentIndexChenged(); }
    }
}
