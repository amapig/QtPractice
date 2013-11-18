import QtQuick 2.0

Item {
    width: 100
    height: 62

    function formatTime(t) {
        t = t / 1000;
        var secs = Math.floor(t % 60);
        t = t / 60;
        var mins = Math.floor(t);
        if (secs < 10) secs = "0" + secs;
        return mins + ":" + secs;
    }

    Text {
        id: lblPosition
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignRight
        width: 64
        color: "green"
        text: formatTime(player.position)
        font.pixelSize: 20
    }

    ProgressBar {
        id: progressBar
        anchors.left: lblPosition.right
        anchors.leftMargin: 12
        anchors.right: lblTotal.left
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        value: player.position / player.duration

        onClicked: {
            var millisecs = player.duration * value;
            player.position = millisecs;
            player.seek(player.position);
        }
    }

    Text {
        id: lblTotal
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignRight
        width: 64
        color: "#a99d97"
        text: formatTime(player.duration)
        font.pixelSize: 20
    }
}
