import QtQuick 2.0

Item {
    property bool isFirst : false;
    width: 200
    height: 200

    Loader {
        id: pageLoader
        sourceComponent: rect
    }

    MouseArea {
        anchors.fill: parent
        onClicked: changePage();
    }

    function changePage() {
        if(isFirst) {
            pageLoader.source = "Page1.qml"
        } else {
            pageLoader.source = "Page2.qml"
        }

        isFirst = !isFirst;
    }

    Component {
        id: rect
        Rectangle {
            width: 200
            height: 50
            color: "red"
            Text {
                text: "Default Page"
                anchors.fill: parent
            }
        }
    }

}
