import QtQuick 2.0

Rectangle {
    id: page
    width: 614; height: 54
    color: "#7bffffff"
    radius:5

    MouseArea {
        anchors.fill: parent
        onClicked: page.focus = false;
    }
    ShadowRectangle {
        color: "#434343"
        transformOrigin: "Center"
        opacity: 0.97
        visible: true
        anchors.centerIn: parent; width: 610; height: 50
    }
    TextBox {
        id: search;
        visible: true
        opacity: 1
        anchors.centerIn: parent
    }
}
