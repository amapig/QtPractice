import QtQuick 2.0

Item {
    width: 500; height: 500

    Component {  // Just can contain one child
        id: redSquare

        Item {
            Rectangle {
                color: "red"
                width: 100
                height: 100

                Text {
                    color: "white"
                    text: "hello"
                }
            }

            Rectangle {
                color: "blue"
                width: 50
                height: 50
            }
        }

    }

    Loader { sourceComponent: redSquare }
    Loader { sourceComponent: redSquare; x: 200}
}
