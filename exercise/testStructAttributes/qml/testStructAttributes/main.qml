import QtQuick 2.0

 Rectangle {
     width: 240
     height: 320
     color: palette.background

     Text {
         anchors.centerIn: parent
         color: palette.text
         text: "Click me to change color!"
     }

     MouseArea {
         anchors.fill: parent
         onClicked: {
             palette.text = "blue";
         }
     }
 }
