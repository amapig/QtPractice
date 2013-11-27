import QtQuick 2.0
import Qt.labs.folderlistmodel 2.0

Rectangle {
    id: root

    width: 600
    height: 800

//    GridView {
//        width: 200; height: 400

//        model: FolderListModel {
//            id: folderModel

//            folder: "/home/mengcong/Videos"
//            nameFilters: ["*.3gp", "*.jpg"]
//        }

//        delegate: Column {
//            id: fileDelegate
//            Text { text: fileName; anchors.horizontalCenter: parent.horizontalCenter }
//            Text { text: "00:00"; anchors.horizontalCenter: parent.horizontalCenter }
//        }

//    }

    GridView {
        id: gridView
        width: parent.width
        height: parent.height

        cellWidth: root.width/3
        cellHeight: root.height/3
        anchors.horizontalCenter: parent.horizontalCenter

        model: FolderListModel {
            id: folderModel

            folder: "/home/mengcong/Videos"
            nameFilters: ["*.3gp", "*.3GP", "*.jpg"]
        }

        delegate: Column {
            id: fileDelegate
            Image {
                id: thumbnail
                source: "file:///home/mengcong/workspace/codes/exercise/testFolderListModel/qml/testFolderListModel/GridVideoThumbnail.jpg" // portrait

                // TODO: Switch to playing interface.
                MouseArea {
                    anchors.fill: thumbnail
                    onClicked: {
                        // console.log("index = " + index + "\n" + "currentIndex = " + playQueue.currentIndex )
                        // gridView.clickedthumbnail("file://" + playQueue.getPath(index))
                        console.log("index = " + index)
                    }
                }
            }

            Text {
                text: fileName
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "00:00"
                anchors.horizontalCenter: parent.horizontalCenter
            }

        }

    }

}
