import QtQuick 2.0
import net.cmos.ringtoneselector 1.0

Rectangle {
    width: 600
    height: 800

    RingtoneSelector {
        id: ringtoneSelector
        anchors.fill: parent

        sourceFolder: "/home/mengcong/Music/mp3"

        onRingtoneChanged: {
            console.log("ring tone changed to: " + fileName)
        }
    }

}
