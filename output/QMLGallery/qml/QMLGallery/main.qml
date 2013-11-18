import QtQuick 2.0

Rectangle {
    width: 600
    height: 800

    function addThumbnail(){
        mediaListView.addItem();
    }
    function removeThumbnail(){
        mediaListView.removeItem();
    }
    function scaleGridView(){
        mediaListView.scaleItems();
    }
    function selectAllItems(){
        mediaListView.selectAllItems();
    }
    function unselectAllItems(){
        mediaListView.unselectAllItems();
    }
    /*
     * Argument: direction, 1 is zoom out, 0 is zoom in
     */
    function zoomIn(){
        console.log("zoomIn Invoked" );
        mediaListView.scaleItems(0);
    }
    /*
     * Argument: direction, 1 is zoom out, 0 is zoom in
     */
    function zoomOut(){
        console.log("zoomOut Invoked" );
        mediaListView.scaleItems(1);
    }

    Row{
        id:buttonList
        spacing: parent.width / 30
        anchors.horizontalCenter: parent.horizontalCenter
        height: 75

        Rectangle {
            id: addbutton
            color: "grey"
            width: 80; height: 75
            Text{
                anchors.centerIn: parent
                text: "add button"
            }
            MouseArea{
                    anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
                            //onClicked handles valid mouse button clicks
                    onClicked: {
                      console.log("add button clicked" );
                      addThumbnail()
                    }
                }
        }

        Rectangle {
            id: removebutton
            color: "grey"
            width: 80; height: 75

            Text{
                anchors.centerIn: parent
                text: "remove button"
            }
            MouseArea{
                    anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
                            //onClicked handles valid mouse button clicks
                    onClicked: {
                        removeThumbnail();
                        console.log("remove button clicked" );
                    }

            }
        }

        Rectangle {
            id: zoomInbutton
            color: "grey"
            width: 80; height: 75

            Text{
                anchors.centerIn: parent
                text: "zoomIn"
            }
            MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        zoomIn();
                    }
            }
        }

        Rectangle {
            id: zoomOutbutton
            color: "grey"
            width: 80; height: 75

            Text{
                anchors.centerIn: parent
                text: "zoomOut"
            }
            MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        zoomOut();
                    }
            }
        }

        Rectangle {
            id: selectAllButton
            color: "grey"
            width: 80; height: 75

            Text{
                anchors.centerIn: parent
                text: "selectAll"
            }
            MouseArea{
                    anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
                            //onClicked handles valid mouse button clicks
                    onClicked: {
                        selectAllItems();
                        console.log("select all button clicked" );
                    }

            }
        }

        Rectangle {
            id: unselectAllButton
            color: "grey"
            width: 80; height: 75

            Text{
                anchors.centerIn: parent
                text: "unselect all button"
            }
            MouseArea{
                    anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
                            //onClicked handles valid mouse button clicks
                    onClicked: {
                        unselectAllItems();
                        console.log("select all button clicked" );
                    }

            }
        }
    }


    MediaListView{
        id:mediaListView
        anchors.top: buttonList.bottom
    }


    /*
    MouseArea {
        anchors.fill: parent
        onClicked: {
            //Qt.quit();
        }
    }*/
}
