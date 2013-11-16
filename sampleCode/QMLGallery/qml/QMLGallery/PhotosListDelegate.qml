import QtQuick 2.0
import "PhotosListDelegate.js" as PhotoListFunc

Component{
    id:photosListDelegate
    GridView{
        id:photoListDelegate
        objectName: "photoListDelegate"
        width: ListView.view.width
        height: PhotoListFunc.countGridViewHeight(photoListDelegate, cellWidth ,headerHeight)
        property int myViewPadding:2
        cellWidth: (width- 2) / 6
        cellHeight: cellWidth
        property Component internalDelegate:  PhotoGridDelegate{}
        delegate: internalDelegate
        model: TestModel1{}
        property int headerHeight: 20
        property var gridsPerLine: [6, 8, 16]
        header: Rectangle{
                height:headerHeight
                Text {
                    text: "this is a sample Header";
                    font.family: "Helvetica";
                    font.pointSize: 12;
                    color: "red"
                }
        }
        interactive: false //disable the flip effect


        function appendNewItemsToModel(){
            PhotoListFunc.appendNewItemsToModel(photoListDelegate);
        }

        function removeItemFromModel(){
             PhotoListFunc.removeItemFromModel(photoListDelegate);
        }

        function selectAllItems(){
            PhotoListFunc.selectAllItems(photoListDelegate);
        }

        function unselectAllItems(){
            PhotoListFunc.unselectAllItems(photoListDelegate)
        }

        function scaleItems(direction){
            PhotoListFunc.scaleItems(direction, photoListDelegate);
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                photoListDelegate.currentIndex = photoListDelegate.indexAt(mouse.x,mouse.y);
                PhotoListFunc.selectItems(photoListDelegate.currentItem,photoListDelegate)
            }
        }

        onStateChanged: {
            console.log("photoListDelegate state changed : ", photoListDelegate.state);
        }
        states: [
           State {
               name: "TopLevel"
               PropertyChanges { target: photoListDelegate; cellWidth: PhotoListFunc.countGridSize(2, gridsPerLine[0], photoListDelegate)}
           },
           State {
               name: "SecondLevel"
               PropertyChanges { target: photoListDelegate; cellWidth: PhotoListFunc.countGridSize(2, gridsPerLine[1], photoListDelegate)}
           },
           State {
               name: "ThirdLevel"
               PropertyChanges { target: photoListDelegate; cellWidth: PhotoListFunc.countGridSize(2, gridsPerLine[2], photoListDelegate)}
           }
        ]
    }
}
