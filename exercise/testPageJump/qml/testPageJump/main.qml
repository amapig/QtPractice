import QtQuick 2.0

Component {
    id: menuDelegate

    Rectangle {
        x: 2
        width: parent.width - x * 2
        height: 70
        radius: 5
        border.color: "red"

        Text {
            anchors.fill: parent
            text: title
            font.bold: true;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignHCenter;
            font.pointSize: 16
            color: "blue"
        }

        // 鼠标区域
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (title == "开启蓝牙")
                {
                    // 创建对象
                    var object = Qt.createComponent("Bluetooth.qml").createObject(window)
                    object.title = "蓝牙设置页面，点击关闭"
                }
            }
        }
    }
}
