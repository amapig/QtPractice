import QtQuick 2.0

Rectangle {
    id: signal1
    width: 200; height: 200
    state: "CRITICAL"

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: signal; color: "green"}
            PropertyChanges { target: flag; state: "FLAG_DOWN"}
        },
        State {
            name: "CRITICAL"
            PropertyChanges { target: signal; color: "red"}
            PropertyChanges { target: flag; state: "FLAG_UP"}
        }
    ]
}
