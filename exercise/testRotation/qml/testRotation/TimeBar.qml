import QtQuick 2.0

Item {
    opacity: 1
    property Player qmlPlayer

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
        text: formatTime(qmlPlayer.getPosition())
        font.pixelSize: 20
    }

    Progressbar {
        id: progressBar
        anchors.left: lblPosition.right
        anchors.leftMargin: 12
        anchors.right: lblTotal.left
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        value: qmlPlayer.getPosition() / qmlPlayer.getDuration()

        onSigseek: {
            console.log("Seek to: " + qmlPlayer.getPosition())
            var millisecs = qmlPlayer.getDuration() * value;
            qmlPlayer.getPosition() = millisecs;
            qmlPlayer.seek(qmlPlayer.getPosition());
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
        text: formatTime(qmlPlayer.getDuration())
        font.pixelSize: 20
    }
}
