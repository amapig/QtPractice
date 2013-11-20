/*!
     *
     * @scope Nokia Meego
     *
     * @class QmBattery
     * @brief QmBattery provides information on device battery status.
     */

import QtQuick 2.0

Image {
    property string source1: ""
    property string source2: ""

    signal clicked()

    id: btn
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
                target: btn
                source: source2
            }
        }
    ]
}
