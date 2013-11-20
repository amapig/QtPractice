import Qt 4.7

Rectangle {
    id: button;

    property alias icon: buttonIcon.source;
    property string statusTip: "";

    signal clicked();
    signal doubleClicked();
    signal pressed();
    signal released();
    signal entered();
    signal exited();
    signal showStatusTip(string sTip);

    width: 32;
    height: 32;
    smooth: true;
    radius: height / 4;

    SystemPalette {
        id: palette;
    }

    gradient: Gradient {
        GradientStop {
            position: 0.0;
            color: Qt.lighter(palette.dark, 1.0);
        }
        GradientStop {
            position: 1.0;
            color: "black";
        }
    }

    Image {
        id: buttonIcon;
        source: parent.icon;
        anchors.fill: parent;
        fillMode: Image.PreserveAspectCrop;
        smooth: true;
    }

    MouseArea {
        id: buttonMouseArea;
        anchors.fill: parent;
        hoverEnabled: true;
        onClicked: {
            parent.clicked();
        }
        onDoubleClicked: {
            parent.doubleClicked();
        }
        onPressed: {
            parent.pressed();
        }
        onReleased: {
            parent.released();
        }
        onEntered: {
            parent.entered();
            parent.showStatusTip(button.statusTip);
        }
        onExited: {
            parent.exited();
        }
    }
}
