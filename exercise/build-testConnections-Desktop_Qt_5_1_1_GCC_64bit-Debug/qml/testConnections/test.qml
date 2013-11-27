import QtQuick 2.0

Rectangle {
    width: 100
    height: 62

    function foo() {console.log("hello world")}

    Connections {
        target: mouseArea
        onClicked: foo()
    }
}
