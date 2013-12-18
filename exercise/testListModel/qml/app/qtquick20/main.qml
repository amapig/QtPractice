import QtQuick 2.0
import com.cmos.widget 1.0

Rectangle {
    width: 1080
    height: 1920

    color: "red"
    opacity: 0.9

    ListModel {
        id: listModel

        ListElement { name: "hello world"; text: "全部视频" }
        ListElement { name: "globalVideos"; text: "本机视频" }
        ListElement { name: "otherVideos"; text: "非本机视频" }
    }

    ListView {
        id: videoFilterList

        width: parent.width
        height: parent.height
        topMargin: 18
        model: listModel
        spacing: 10
        snapMode: ListView.SnapOneItem
        anchors.horizontalCenter: parent.horizontalCenter

        delegate: CMOS_Button {
            id: filterButton

            text: model.text
            borderWidth: 0
            isHorizontal: false
            bgColor: "lightgray"
            fontColor: "black"

            onClicked: {
                console.log("index = " + index + "name = " + listModel.get(index).name)
            }
        }
    }

}

