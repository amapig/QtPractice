import QtQuick 2.0
import QtQuick.LocalStorage 2.0
//import "storage.js" as Storage

Rectangle {
    width: 1080
    height: 1920

    //    //引入storage.js，起个别名Storage，以供后面使用
    //    Text {
    //        id: textDisplay
    //        anchors.centerIn: parent
    //    }

    //    Component.onCompleted: {
    //        // 初始化数据库
    //        Storage.initialize();
    //        // 赋值
    //        Storage.setSetting("mySetting","myValue");
    //        Storage.setSetting("mySetting", "meng");
    //        Storage.setSetting("mySetting", "cong");
    //        //获取一个值，并把它写在textDisplay里
    //        textDisplay.text = "The value of mySetting is:\n" + Storage.getSetting("mySetting");

    //        console.log("getSetting = " + Storage.getSetting("mySetting"));
    //    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("clear()");
            videosDB.clear();
            videosDB.insertPosition("/home/skytree/mengcong.3gp", 100, 101, 102)
        }
    }

}
