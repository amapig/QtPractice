import QtQuick 2.0
import QtQuick.Controls 1.0
import com.nokia.meego 2.0
import QtQuick.Controls.Styles 1.0

TabView{
    id: tabview
    objectName: "tabview"
    anchors.fill: parent
    tabPosition: Qt.BottomEdge
    property int  theight: 110
    property int  tfont: 36

    style: TabViewStyle{
        tab: Item {
            id : tabbar
            //scale: control.tabPosition === Qt.TopEdge ? 1 : -1

            property int totalOverlap: tabOverlap * (control.count - 1)
            property real maxTabWidth: (styleData.availableWidth + totalOverlap) / control.count

            //== cao
            //implicitWidth: Math.round(Math.min(maxTabWidth, textitem.implicitWidth + 20))
            implicitWidth: Math.round(Math.max(maxTabWidth, textitem.implicitWidth + 20))
            implicitHeight: Math.round(textitem.implicitHeight + 10)

            height: tabview.theight;
            clip: true
            Item {
                anchors.fill: parent
                anchors.bottomMargin: styleData.selected ? 0 : 2
                clip: true
                BorderImage {
                    anchors.fill: parent
                    source: styleData.selected ? "images/tab_selected.png" : "images/tab.png"
                    border.top: 6
                    border.bottom: 6
                    border.left: 6
                    border.right: 6
                    anchors.topMargin: styleData.selected ? 0 : 1
                }
                BorderImage {
                    anchors.fill: parent
                    anchors.topMargin: -2
                    anchors.leftMargin: -2
                    anchors.rightMargin: -1
                    source: "images/focusframe.png"
                    visible: styleData.activeFocus && styleData.selected
                    border.left: 4
                    border.right: 4
                    border.top: 4
                    border.bottom: 4
                }
            }
            Text {
                id: textitem
                anchors.centerIn: parent
                text: styleData.title
                renderType: Text.NativeRendering
                //scale: control.tabPosition === Qt.TopEdge ? 1 : -1
                color: __syspal.text
                font.pixelSize: tfont
            }
        }


    }

}

