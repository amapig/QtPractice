import QtQuick 2.0

GridView {
    id: thumbnailsView

    cellWidth: thumbnailsView.width/3
    cellHeight: thumbnailsView.height/3

    // Replace the model with the actual videos'data.
    model: ListModel {

        ListElement {
            name: "Jim Williams"
            portrait: "qrc:/image/image/GridVideoThumbnail.jpg"
        }

        ListElement {
            name: "John Brown"
            portrait: "qrc:/image/image/GridVideoThumbnail.jpg"
        }

        ListElement {
            name: "Bill Smyth"
            portrait: "qrc:/image/image/GridVideoThumbnail.jpg"
        }

        ListElement {
            name: "Sam Wise"
            portrait: "qrc:/image/image/GridVideoThumbnail.jpg"
        }
    }

    delegate: Column {
        Image {
            //source: portrait
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: name
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "00:00"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}
