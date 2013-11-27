import QtQuick 2.0
import Qt.labs.folderlistmodel 2.0

// Component {
Item {
    id: fileDelegate

    Item {
        width: 600
        height: 400
        Image {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            source: "file://" + filePath
        }

        Image {
            anchors.centerIn: parent
            source: "play_1.png"
        }
    }

}

