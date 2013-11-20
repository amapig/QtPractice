import Qt 4.7

Rectangle {
    id: razer;

    width: 350;
    height: 150;

    function showStatusTip(string) {
        console.log(arguments[0]);
    }

    SystemPalette {
        id: palette;
    }

    Background {
        id: background;
        anchors.fill: parent;
    }

    TitleBar {
        id: titleBar;

        width: parent.width;
        anchors.top: parent.top;
        opacity: 0.8;
    }

    Component.onCompleted: {
        titleBar.showStatusTip.connect(razer.showStatusTip);
    }
}
