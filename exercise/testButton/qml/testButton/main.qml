import QtQuick 2.0

Rectangle {
    id: labelList
    Row {
        anchors.centerIn: parent
        spacing:40

        Button {
            label: "File"
            id: fileButton

            onButtonClick: menuListView.currentIndex = 0
        }

        Button {
            id: editButton
            label: "Edit"
            onButtonClick:    menuListView.currentIndex = 1
        }
    }
}
