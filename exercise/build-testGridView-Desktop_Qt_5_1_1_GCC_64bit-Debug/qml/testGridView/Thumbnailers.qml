import QtQuick 2.0

GridView {
    id: gridView


    model: ListModel {
        id: myModel

        ListElement { type: "Dog"; age: 8 }
        ListElement { type: "Cat"; age: 5 }
        ListElement { type: "Cat"; age: 5 }
        ListElement { type: "Cat"; age: 5 }
        ListElement { type: "Cat"; age: 5 }
        ListElement { type: "Cat"; age: 5 }
        ListElement { type: "Cat"; age: 5 }
        ListElement { type: "Cat"; age: 5 }
    }

    delegate: Column {
        Image {
            id: thumbnail
            // TODO: Set each video's thumbnail.
            width: gridView.width/3.5
            height: gridView.width/3.5
            // anchors.rightMargin: 15
            source: "/home/mengcong/workspace/codes/exercise/testGridView/qml/testGridView/GridVideoThumbnail.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "name"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "00:00" // TODO: Get duration for each video.
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

}
