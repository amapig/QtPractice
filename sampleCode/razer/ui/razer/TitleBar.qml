import Qt 4.7

Rectangle {
    id: titleBar;
    property alias text: title.text;

    signal showStatusTip(string statusTip);

    height: 18;
    smooth: true;

    SystemPalette {
        id: palette;
    }

    gradient: Gradient {
        GradientStop {
            position: 0.0;
            color: "black";
        }
        GradientStop {
            position: 1.0;
            color: palette.dark;
        }
    }

    Item {
        id: container;
        width: (parent.width - title.width) * 2;
        height: parent.height;
        x: -title.x + 4;

        Text {
            id: title;
            text: "Razer";
            x: container.width / 2;
            color: "white";
            style: Text.Sunken;
            styleColor: palette.light;
            smooth: true;
            anchors.verticalCenter: parent.verticalCenter;

            MouseArea {
                id: titleMouseArea;
                anchors.fill: parent;
                hoverEnabled: true;
                onEntered: {
                    titleBar.showStatusTip(titleBar.state == "menuBar" ?
                                               qsTr("Hide menu bar.") : qsTr("Show menu bar."));
                }

                onClicked: {
                    titleBar.state = titleBar.state == "menuBar" ? "" : "menuBar";
                }
            }
        }

        Button {
            id: quitButton;

            statusTip: qsTr("Quit");
            height: titleBar.height - 2;
            width: height;
            border {
                width: 1;
                color: Qt.darker(palette.button, 2.0);
            }
            anchors.verticalCenter: parent.verticalCenter;
            x: title.x + container.width / 2 + title.width / 2 - 6;
            icon: "images/quit.png";

            onEntered: {
                titleBar.showStatusTip(statusTip);
            }

            onPressed: {
                quitButton.opacity = 0.8;
            }

            onClicked: {
                Qt.quit();
            }

            onReleased: {
                quitButton.opacity = 1.0;
            }
        }
    }

    states: State {
        name: "menuBar";
        PropertyChanges {
            target: container;
            x: -4;
        }
    }

    transitions: Transition {
        NumberAnimation {
            properties: "x";
            duration: 800;
            easing.type: Easing.OutBack;
        }
    }

}
