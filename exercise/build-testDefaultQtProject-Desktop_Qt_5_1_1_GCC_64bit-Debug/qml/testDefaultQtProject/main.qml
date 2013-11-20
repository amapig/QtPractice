import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0

//Rectangle {
//    width: 360
//    height: 360
//    Text {
//        text: qsTr("Hello World")
//        anchors.centerIn: parent
//    }
//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//            Qt.quit();
//        }
//    }
//}
Rectangle {
    width: 360
    height: 360
//    GridLayout {
//        id: grid
//        columns: 3
//        Text { text: "Three" }
//        Text { text: "words" }
//        Text { text: "in" }
//        Text { text: "a" }
//        Text { text: "row" }
//    }

    ComboBox {
        model: ListModel {
            id: cbItems
            ListElement { text: "Banana"; color: "Yellow" }
            ListElement { text: "Apple"; color: "Green" }
            ListElement { text: "Coconut"; color: "Brown" }
        }
        width: 200
        onCurrentIndexChanged: console.debug(currentText + ", " + cbItems.get(currentIndex).color)
    }

}
