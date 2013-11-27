import QtQuick 2.0

Rectangle {
    id: test
    property alias mcconnect: MouseArea
    width: 100
    height: 62

    function foo() {console.log("hello world")}

    Connections {
        target: mouseArea
        onClicked: foo()
    }
}
