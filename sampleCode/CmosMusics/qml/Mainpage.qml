import QtQuick 2.0
import com.nokia.meego 2.0

Page {
    id:mainpage
    anchors.fill: parent

    property bool bListvisible: true

    Component.onCompleted: {
        console.log("UI loaded")
    }


    function pushQml(file) {
            var component = Qt.createComponent(file)
            if (component.status == Component.Ready)
                pageStack.push(component);
            else
                console.log("Error loading component:", component.errorString());
    }


    Titlebar{
        id:titlebar1
        visible: bListvisible
        width:parent.width
        height: parent.height/10
        //color: "red"
        anchors.top: parent.top;
        anchors.left: parent.left
        onBacksig: {
            console.log("exit application");
            Qt.quit();
        }
        onMenusig: {
            console.log("menu pressed, pop a menu in mainpage");
        }
    }

    ListView {
        id: listView
        anchors.top: titlebar1.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        visible:bListvisible

        delegate: Rectangle {
            id: item            
            height: 150
            anchors.left: parent.left
            width:parent.width

            MouseArea{
                id:mouseitem
                hoverEnabled : true
                anchors.fill: parent
                onClicked:{
                    console.log("clicked on item:"+index);
                    if(index == 0)
                    {
                        pushQml("Musiclist.qml");
                    }
                }
            }

            Row {
                id: rowId
                spacing: 15

                height: parent.height

                Image{
                    id:itemicon
                    visible:true
                    height: parent.height
                    width:parent.height
                    fillMode:Image.PreserveAspectCrop
                    source:iconsrc
                    verticalAlignment:Image.AlignVCenter
                    horizontalAlignment:Image.AlignHCenter
                }

                Text {
                    text: name
                    font.pointSize: 30
                    font.bold: true
                    height: parent.height
                    verticalAlignment:Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }
        model: ListModel {
            id: listModel

            ListElement {
                name: "全部音乐"
                colorCode: "grey"
                iconsrc:"qrc:/image/image/folder.png"
            }

            ListElement {
                name: "My favorite"
                colorCode: "red"
                iconsrc:"qrc:/image/image/folder.png"
            }
        }
    }
}
