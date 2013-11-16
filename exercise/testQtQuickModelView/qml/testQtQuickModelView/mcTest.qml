import QtQuick 2.0

Rectangle {
    width: 200
    height: 200

    ListModel {
        id: mcListModel
        ListElement {type: "mc1"; age: 100; color: "red"}
        ListElement {type: "mc2"; age: 100; color: "blue"}
    }

    Component {
        id: mcDelegate
        Text {
            color: "blue"
            text: "hello " + type + " , " + age + " , " + mcListModel.color
        }
    }

    ListView {
        id: mcListView
        anchors.fill: parent
        model: mcListModel
        delegate: mcDelegate
    }
}
