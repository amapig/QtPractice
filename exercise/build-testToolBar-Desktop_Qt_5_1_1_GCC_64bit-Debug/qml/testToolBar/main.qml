import QtQuick 2.0

Rectangle {
    width: 600
    height: 800

    Titlebar {
        id:filterBar
        visible: bListvisible
        width:parent.width
        height: parent.height/10
        color: "black"
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

    // search box
    Rectangle {
        id: searchBar
        width: filterBar.width
        height: filterBar.height - 20
        y: filterBar.height
        color: "gray"

        MouseArea {
            anchors.fill: parent
            onClicked: page.focus = false;
        }

        // mc: Shadow effects
        ShadowRectangle {
            color: "lightgray"
            transformOrigin: "Center"
            //opacity: 0.97
            visible: true
            // anchors.centerIn: parent
            width: parent.width
            // height: parent.height
            anchors.top: parent.top -5
            anchors.bottom: parent.bottom - 5
        }

        TextBox {
            id: search;
            visible: true
            opacity: 1
            // anchors.centerIn: parent
            width: searchBar.width - 200
//            height: searchBar.height - 20
            anchors.top: searchBar.top - 5
            anchors.bottom: searchBar.bottom - 5
//            anchors.right: parent.right - 100
        }

    }

    //    Titlebar {
    //        id:searchBar
    //        visible: bListvisible
    //        y: filterBar.height
    //        width:parent.width
    //        height: parent.height/10
    //        color: "gray"
    //        onBacksig: {
    //            console.log("exit application");
    //            Qt.quit();
    //        }
    //        onMenusig: {
    //            console.log("menu pressed, pop a menu in mainpage");
    //        }
    //    }


}
