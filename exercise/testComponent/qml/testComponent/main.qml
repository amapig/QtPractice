import QtQuick 2.0

Rectangle {
    width: 360
    height: 360
    property bool isLeftVisible : false
    property bool isRightVisible : false
    Loader { id: testLoader }

    Component.onCompleted: {
        console.log("Component on completed.");
        testLoader.source = "Left.qml"
        isLeftVisible = true;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("press clicked");
            testLoader.source = "Right.qml"
            isLeftVisible = false;
            isRightVisible = true;
        }
    }

}
