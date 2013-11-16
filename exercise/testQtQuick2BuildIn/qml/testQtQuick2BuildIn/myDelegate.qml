import QtQuick 2.0

Rectangle {
    width: 500; height: 500

    Component {
         id: myDelegate

         Text {
             text: "Hello"
             color: ListView.isCurrentItem ? "red" : "blue"
         }
    }

    ListView {
         delegate: myDelegate
    }

}
