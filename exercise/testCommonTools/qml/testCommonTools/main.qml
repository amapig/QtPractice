import QtQuick 2.0
import QtQuick.Window 2.0
import com.cmos.widget 1.0

Item {
    width: 600
    height: 800

    CMOS_LineEdit {
        id:lineEdit
        anchors.centerIn: parent
        anchors.margins: 30

        onTextChanged: {
            console.log("CMOS_LineEdit onTextChanged:",lineEdit.getText())
        }
    }

}
