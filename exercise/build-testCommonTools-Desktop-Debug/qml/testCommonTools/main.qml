import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

// import "Cmos_Practice"

Rectangle {
    width: 600
    height: 800

    CMOS_LineEdit{
        id:lineEdit
        anchors.top: fiveRow.bottom
        anchors.margins: 5
        visible:false
        onTextChanged: {
            console.log("CMOS_LineEdit onTextChanged:",lineEdit.getText())
        }
    }

}
