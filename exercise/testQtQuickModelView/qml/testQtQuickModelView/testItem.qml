import QtQuick 2.0

Item {
    width: 200; height: 250

    Component {
        id: itemDelegate
        Text { text: "I am item number: " + index }
    }

    ListView {
        anchors.fill: parent
        model: 5
        delegate: itemDelegate
    }

}
