/*!
 * Author: Mengcong
 * Date: 2013.11.18
 * Details: Image button tool.
 */

import QtQuick 2.0

Image {
    id: imageBtn

    property string source1: ""
    property string source2: ""

    signal clicked()

    source: source1
    fillMode: Image.PreserveAspectFit

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            parent.clicked()
        }
    }

    states: [
        State {
            name: "pressed"
            when: mouseArea.pressed
            PropertyChanges {
                target: imageBtn
                source: source2
            }
        }
    ]
}
