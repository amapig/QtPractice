import QtQuick 2.0

Component {
    id: photoGridDelegate
    //property bool isSelected: false
    Rectangle {
        id: photoGridDelegateItem
        width: GridView.view.cellWidth
        height: GridView.view.cellHeight
        border.width: 5
        border.color: "red"
        radius:10
        onStateChanged: {
            console.log("state changed in photoGridDelegateItem "+state);
        }

        Image {
            id: myIcon2
            anchors.left: parent.left
            source: icon
            width: photoGridDelegateItem.width
            height: photoGridDelegateItem.height

        }

        Image {
            id: myIcon
            anchors.left: parent.left
            source: icon
            width: photoGridDelegateItem.width
            height: photoGridDelegateItem.height

        }

        Text {
            text: "|-" + name
            anchors.left: parent.left
        }
        Text {
            text: date + "-|"
            anchors.right: parent.right
        }

        states: [
            State {
                name: "UNSELECTED"
                PropertyChanges {
                    target: photoGridDelegateItem;
                    border.color: "red"
                }

            },
            State {
                name: "SELECTED"
                PropertyChanges {
                    target: photoGridDelegateItem;
                    border.color: "blue"
                }
            }
        ]
    }
}
