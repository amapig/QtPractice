import QtQuick 2.0

// 蓝牙设置页面
Rectangle {
    id: page
    anchors.fill: parent

    // 属性
    property alias title: titleText.text

    // 构造函数
    Component.onCompleted: {
        console.log("Create Bluetooth Page.")
    }

    // 析构函数
    Component.onDestruction: {
        console.log("Destroy Bluetooth Page.")
    }

    // 标题
    Text {
        id: titleText
    }

    // 鼠标区域
    MouseArea {
        anchors.fill: parent
        onClicked: {
            page.destroy()
        }
    }
}
