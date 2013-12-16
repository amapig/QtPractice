/*!
 * Author: Mengcong
 * Date: 2013.11.19
 * Details: Search bar for the player.
 */

import QtQuick 2.0

Rectangle {
    id: searchBar

    width: 600
    height: 200

    color: "lightgray"

    SearchBox {
        id: searchBox

        visible: true
        opacity: 1
        anchors.centerIn: parent
    }

    TextButton {
        width: parent.width/6
        height: parent.height/2
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: "搜索"

        // TODO: Response the search event.
        onClicked: {
            console.log("Search button!")
            searchBox.focus = false
            if(searchBox.getSearchStr() !== 0) {
                console.log("search: " + searchBox.getSearchStr())
            }
        }
    }

}
