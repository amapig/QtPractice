import QtQuick 2.0
import com.cmos.widget 1.0

Rectangle {
    width: 600
    height: 800

    CMOS_Button {
        text: "Audio Player"
        anchors.centerIn: parent
        onClicked: {
            audioPlayer.setDataSource(/*"file://" + */"/home/skytree/Music/1.mp3");
            audioPlayer.play()
        }
    }

}
