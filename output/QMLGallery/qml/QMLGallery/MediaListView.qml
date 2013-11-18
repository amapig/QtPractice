import QtQuick 2.0

ListView {
    id: mediaListView
    width: parent.width
    height: parent.height
    delegate: PhotosListDelegate{}
    model: PhotoListModel{}

    function addItem(){
        mediaListView.currentIndex = 0;
        mediaListView.currentItem.appendNewItemsToModel();
    }

    function removeItem(){
        for(var i=0; i<mediaListView.count; i++){
            mediaListView.currentIndex = i;
            mediaListView.currentItem.removeItemFromModel();
        }
        mediaListView.positionViewAtBeginning();//return back to the top of the view
        //ListView::positionViewAtIndex ( int index, PositionMode mode )

    }

    function selectAllItems(){
        for(var i=0; i<mediaListView.count; i++){
            mediaListView.currentIndex = i;
            mediaListView.currentItem.selectAllItems();
        }
        mediaListView.positionViewAtBeginning();//return back to the top of the view
    }

    function scaleItems(direction){
        console.log("&&&&&&&&&&& ")
        for(var i=0; i<mediaListView.count; i++){
            mediaListView.currentIndex = i;
            mediaListView.currentItem.scaleItems(direction);
        }
    }
    function unselectAllItems(){
        console.log("UUUUUUUUUUUUUUUUUUUUUUUUU")
        for(var i=0; i<mediaListView.count; i++){
            mediaListView.currentIndex = i;
            mediaListView.currentItem.unselectAllItems();
        }
        mediaListView.positionViewAtBeginning();//return back to the top of the view
    }

    /*
    function getDelegateInstance(index){
        for(var i; mediaListView.children.length; ++i){
            var item = mediaListView.children[i];
            if(item.objectName=="photoListDelegate" && item.index==index){
                return item;
            }
        }
        return undefined;
    }*/
}
