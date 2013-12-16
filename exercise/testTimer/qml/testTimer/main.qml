import QtQuick 2.0

Rectangle {
    width: 360
    height: 360

    property int i : 0

    function testTimer() {
        console.log("++++++++i = " + (i++) + "++++++++");
    }

    Timer {
        interval: 5000;
        running: true;
        repeat: true
        onTriggered: time.text = Date().toString()
    }

    Text { id: time }

}
