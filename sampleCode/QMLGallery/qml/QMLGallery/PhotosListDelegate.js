function func() {
    console.log("@@@@@@@@@@@@@@@")
    console.log("@@@@@@@@@@@@@@@2")
}

function countGridViewHeight(gridView, cellWidth ,headerHeight){
    if(gridView != undefined){
        console.log("#### the line number for grid view!"+Math.ceil(gridView.count/4))
        return Math.ceil(gridView.count/6) * cellWidth +headerHeight;
    }else{
        return 0;
    }
}

function countGridSize(viewPadding, gridNumberPerLine,photoListDelegate){
    var myCellWidth = (photoListDelegate.width-viewPadding)/gridNumberPerLine
    return myCellWidth;
}

function appendNewItemsToModel(photoListDelegate){
    photoListDelegate.model.append({name: "Photo1",
                                    date: "2013-02-03",
                                    icon: "qrc:/pics/QtQuick2Test80.png",
                                    color: "red"
                                   });
}

function removeItemFromModel(photoListDelegate){
    console.log("the count of items will be removed",photoListDelegate.count);
    var myDeleteItems = new Array();

    for(var i = photoListDelegate.count ; i >= 1 ; i--){
        photoListDelegate.currentIndex = i -1;
        if(photoListDelegate.currentItem.state == "SELECTED"){
            myDeleteItems.push(photoListDelegate.currentIndex);
        }
    }

    for(var i = 0 ; i< myDeleteItems.length; i++){
        photoListDelegate.model.remove(myDeleteItems[i]);
    }

    photoListDelegate.currentIndex=1;
    //unselectAllItems();
}

function selectItems(argCurrentItem,photoListDelegate){
    //console.log("((((((((((((((())))))))))))))) 1: ",photoListDelegate.currentItem)
    //console.log("((((((((((((((())))))))))))))) 1: ",photoListDelegate.currentItem.state)
    if( "null" != photoListDelegate.currentItem.state ){
        if(argCurrentItem.state != "SELECTED"){
            argCurrentItem.state = "SELECTED";
        }else{
            argCurrentItem.state = "UNSELECTED"
        }
    }
}

/*
 * Argument: direction, 1 is zoom out, 0 is zoom in
 */
function scaleItems(direction, photoListDelegate){
    console.log("photoListDelegate scaleItems :", photoListDelegate.state);
    switch(photoListDelegate.state){
        case "TopLevel":
            if(direction == 1){
                photoListDelegate.state = "SecondLevel";
            }else if(direction == 0){
                console.log("Maximal Size: Can not zoom in")
            }
            break;
        case "SecondLevel":
            if(direction == 1){
                photoListDelegate.state ="ThirdLevel";
            }else if(direction == 0){
                photoListDelegate.state ="TopLevel";
            }
            break;
        case "ThirdLevel":
            if(direction == 1){
                console.log("Minimal Size: Can not zoom out")
            }else if(direction == 0){
                photoListDelegate.state ="SecondLevel";
            }
            break;
        default:
            if(direction == 1){
                photoListDelegate.state = "SecondLevel";
            }else if(direction == 0){
                console.log("Maximal Size: Can not zoom in")
            }
            break;
    }
}


function selectAllItems(photoListDelegate){
    for(var i = 0; i < photoListDelegate.count; i++){
        console.log("select all invoked current index:",i)
        photoListDelegate.currentIndex = i;
        if(photoListDelegate.currentItem.state != "SELECTED"){
            photoListDelegate.currentItem.state = "SELECTED";
        }
    }
}

function unselectAllItems(photoListDelegate){
    for(var i = 0; i < photoListDelegate.count; i++){
        console.log("unselect all invoked current index:",i)
        photoListDelegate.currentIndex = i;
        if(photoListDelegate.currentItem.state != "UNSELECTED"){
            photoListDelegate.currentItem.state = "UNSELECTED";
        }
    }
}
