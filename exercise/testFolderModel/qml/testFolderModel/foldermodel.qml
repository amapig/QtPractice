import QtQuick 2.0
import Qt.labs.folderlistmodel 1.0

Rectangle {
    id: main
    width: 600; height: 400

    FolderListModel {
        id: folderModel
        folder: "/home/mengcong/Pictures"
        nameFilters: ["*.jpg"]
    }

    PhotoDelegate {
        id: photoDelegate

    }

    ListView {
        width: parent.width;
        height:  parent.height

        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        focus: true

        model: folderModel
        delegate: photoDelegate

        onCurrentIndexChanged: {
            console.log("current index changed")
        }
    }

}
