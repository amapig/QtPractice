import QtQuick 2.0
import Qt.labs.folderlistmodel 1.0

ListView {
    width: 200; height: 400

    FolderListModel {
        id: folderModel

        folder: "/home/skytree/Videos"
        nameFilters: ["*.3gp", "*.jpg", "*.mp4"]
    }

    Component {
        id: fileDelegate
        Text { text: fileName }
    }

    model: folderModel
    delegate: fileDelegate
}
