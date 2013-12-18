import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    width: 800
    height: 700
    Column{
        anchors.fill: parent; spacing: 30
        SelectDate{ id: selectDate; anchors.horizontalCenter: parent.horizontalCenter }
        SelectTime{ id: selectTime; anchors.horizontalCenter: parent.horizontalCenter }
        Row{
            width: parent.width * 0.8; height: 40; spacing: 9
            anchors.horizontalCenter: parent.horizontalCenter
            CheckBox{ text: "Year" ; checked: true; onClicked: selectDate.setYearEnabled(checked); }
            CheckBox{ text: "Day" ; checked: true; onClicked: selectDate.setDayEnabled(checked); }
            CheckBox{ text: "Hour" ; checked: true; onClicked: selectTime.setHourEnabled(checked); }
            CheckBox{ text: "Second" ; checked: true; onClicked: selectTime.setSecondEnabled(checked); }

            Button{ text: "TestDate"; onClicked: { text = selectDate.date("/"); } }
            Button{ text: "TestTime"; onClicked: { text = selectTime.time(":"); } }
        }
    }
}
