import QtQuick 2.0
import QtQuick.Controls 1.0

MouseArea{
    id:delegateRoot
    implicitWidth: ListView.view.width-ListView.view.leftMargin-ListView.view.rightMargin
    implicitHeight: 130

    property bool isEditMode:false //always show but different icon show select or not
    property bool canTag:false//true :show else hide
    property bool canDrag:false
    property bool initDragVal:false
    property bool isTagged: false
    property bool dragMoving: false

    property bool movingLeft: false
    property bool movingRight:false

    property int pressX:0
    property int pressY:0

    property Item leftBar:null
    property Item rightBar:null

    property int leftBarMargin:35
    property int rightBarMargin:35

    property bool isExclusive:false
    onIsTaggedChanged: delegateRoot.ListView.view.checkItem(index,isTagged)

    onIsEditModeChanged: {
        if(isEditMode && canDrag)
        {
            initDragVal = canDrag
            canDrag = false
        }
        else
        {
            if(initDragVal)
                canDrag = initDragVal
            isTagged = false
        }

    }
    function toInitState(){
        console.log("toInitState")
        if(drag.target)
        {
            drag.target = null
        }

        backgroundCmpLd.x = 0
        if(leftBar)
        {
            leftBar.x = backgroundCmpLd.x-leftBarMargin
            leftBar.visible = false
            //leftBar.z = parent.z+1
        }
        if(rightBar)
        {
            rightBar.x = backgroundCmpLd.width+rightBarMargin
            rightBar.visible = false
            //rightBar.z = parent.z+1
        }
        movingLeft = false
        movingRight = false

    }
    onDragMovingChanged: {
        if(dragMoving)
        {
            console.log("onDragMovingChanged dragMoving")
            if(!drag.target)
            {
                console.log("onDragMovingChanged drag.target")
                drag.target = backgroundCmpLd
                console.log("onDragMovingChanged ListView.view.curDragItemChanged",index)
                ListView.view.curDragItemChanged(index)
                if(leftBar)
                {
                    console.log("onDragMovingChanged move right")
                    leftBar.parent = delegateRoot
                    leftBar.y = backgroundCmpLd.y
                    leftBar.x = backgroundCmpLd.x-leftBar.width-20
                    leftBar.visible = true
                    //leftBar.z = backgroundCmpLd.z+1
                }
                if(rightBar)
                {
                    console.log("onDragMovingChanged move left")
                    rightBar.parent = delegateRoot
                    rightBar.y = backgroundCmpLd.y
                    rightBar.x = backgroundCmpLd.width+20
                    rightBar.visible = true
                    //rightBar.z = backgroundCmpLd.z+1
                }

            }
        }
        else
        {
            console.log("movingRight && leftBar",width,backgroundCmpLd.x)
            if(movingRight && leftBar)
            {
                console.log("movingRight && leftBar11")
                if(width - backgroundCmpLd.x > 480)
                {
                    console.log("movingRight && leftBar222")
                    drag.target = null
                    movingLeft = false
                    movingRight = false
                    leftBar.visible=false
                    leftBar.x = backgroundCmpLd.x-leftBarMargin
                    backgroundCmpLd.x = 0
                }
            }
        }
    }
    property Component backgroundCmp:backgroundComponent
    Component{
        id:backgroundComponent
        BorderImage{
            id:backgroundImg
            source:delegateRoot.pressed?"images/listbg2.png":"images/listbg.png"
            //fillMode: Image.Stretch
            anchors.fill: parent
            border.top:5
            border.bottom:5
            border.left: 6
            border.right: 6
        }
    }
    property Component editModeCmp:editModeComponent
    Component{
        id:editModeComponent
        CMOS_Button{
            iconSource: delegateRoot.isEditMode?(delegateRoot.isTagged?"images/icontagon.png":"images/icontagoff.png"):(delegateRoot.canTag?(delegateRoot.isTagged?"images/icontagon.png":"images/icontagoff.png"):("images/icontagoff.png"))
            visible: (delegateRoot.isEditMode||(delegateRoot.canTag&&delegateRoot.isTagged))
            lMargin: 50
            tMargin: 1
            rMargin: 1
            bMargin: 1
            z:parent?(parent.z+1):1
            borderWidth: 0
            bgColor: "white"
            //anchors.right: parent.right
            onClicked: delegateRoot.isTagged = !delegateRoot.isTagged
        }
    }


    property Component delegateCmp:delegateComponent
    Component{
        id:delegateComponent
        Rectangle{
            anchors.fill: parent
            color:"white"
            Label{
                text:model.name
            }
        }
    }

    Binding{
        target:backgroundCmpLd.item
        property: "visible"
        value:!lrBarBg.visible//((!(delegateRoot.dragMoving||movingLeft||movingRight))||(backgroundCmpLd.x > -rightBarMargin && backgroundCmpLd.x< leftBarMargin))
    }

    Loader{
        id:backgroundCmpLd
        sourceComponent: backgroundCmp
        width:parent.width
        height:parent.height
        z:parent.z+1
        Loader{
            id:delegateCmpLd
            sourceComponent: delegateCmp
            anchors.left: parent.left
            anchors.leftMargin: delegateRoot.pressed?5:0
            anchors.right: editModeCmpLd.left
            anchors.rightMargin: delegateRoot.pressed?5:0
            //anchors.verticalCenter: parent.verticalCenter
            anchors.top:parent.top
            anchors.topMargin: delegateRoot.pressed?5:0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: delegateRoot.pressed?5:0

            z:parent.z+1
        }
        Loader{
            id:editModeCmpLd
            sourceComponent: (isEditMode||(canTag&&isTagged))?editModeCmp:null
            anchors.right: parent.right
            anchors.rightMargin: 2
            //anchors.verticalCenter: parent.verticalCenter
            anchors.top: delegateCmpLd.top
            //anchors.topMargin: 4
            anchors.bottom: delegateCmpLd.bottom
            //anchors.bottomMargin: 4
            property int itemWidth:0
            onItemChanged: {
                if(!item)
                {
                    width = 0
                }
                else
                {
                    width = Math.max(itemWidth,item.implicitWidth)
                    itemWidth = width
                }
            }

            //anchors.verticalCenter: parent.verticalCenter
            z:parent.z+1
        }
    }


    drag.axis: Drag.XAxis
    drag.minimumX: -backgroundCmpLd.width
    drag.maximumX: backgroundCmpLd.width


    onPressed: {
        if(!canDrag)
        {
            mouse.accepted = false
            return
        }
        pressX = mouseX
        pressY = mouseY
    }
    onPositionChanged: {
        if(!canDrag)
        {
            mouse.accepted = false
            return
        }
        if(!dragMoving)
        {
            console.log("onPositionChanged1")
            if(movingRight || movingLeft )
            {
                console.log("onPositionChanged1 111")
                  dragMoving = true
            }
            else
            {
                console.log("onPositionChanged1 222")
                if(mouseX-pressX > 10 && leftBar)
                {
                    console.log("onPositionChanged2")
                    movingRight = true
                    movingLeft = false
                    dragMoving = true
                }
                else if(mouseX-pressX < -10 &&rightBar)
                {
                    console.log("onPositionChanged3")
                    movingRight = false
                    movingLeft = true
                    dragMoving = true
                }

            }


        }
        else
        {
            console.log("dragMoving  1111111111111")
            if(movingRight)
            {
                console.log("dragMoving  1111111111111 movingRight",backgroundCmpLd.x,leftBar.x,leftBar.z)
                if(backgroundCmpLd.x >= 0)
                {
                    leftBar.x = backgroundCmpLd.x-leftBar.width-leftBarMargin
                }
                else
                {
                    if(rightBar)
                    {
                        movingLeft = true
                        movingRight = false
                    }
                    else
                    {
                        backgroundCmpLd.x = 0
                    }
                }

                console.log("dragMoving  222222222222 movingRight",backgroundCmpLd.x,leftBar.x,leftBar.z)

            }
            else if(movingLeft)
            {
                if(backgroundCmpLd.x<0)
                    rightBar.x = backgroundCmpLd.x+backgroundCmpLd.width+rightBarMargin
                else
                {
                    if(leftBar)
                    {
                        movingRight = true
                        movingLeft = false
                    }
                    else
                    {
                        backgroundCmpLd.x = 0
                    }
                }
            }
            console.log("onPositionChanged  false4")
        }
    }
    onReleased: {
        dragMoving = false
    }
    onCanceled:
    {
        dragMoving = false
    }

    onPressAndHold: {
        ListView.view.changeEditMode()
        console.log("onPressAndHold:",isEditMode)
        if(!isEditMode && canTag)
        {
            isTagged = !isTagged
        }

        if(isEditMode)
        {
            delegateRoot.ListView.view.resetDelegateState()
        }

    }

    onClicked: {
        if(!dragMoving && (movingLeft||movingRight||backgroundCmpLd.x != 0))
            toInitState()
    }
    Rectangle{
        id:lrBarBg
        anchors.fill: parent
        color:movingRight?"#6aca75":(movingLeft?"#72c2e2":"#yellow")
        visible:((dragMoving||movingLeft||movingRight)&&(backgroundCmpLd.x < -2 || backgroundCmpLd.x>2))  //!backgroundCmpLd.item.visible
    }

    Binding{
        target:   delegateRoot
        property: "isEditMode"
        value:delegateRoot.ListView.view.isEditMode
    }

    Binding{
        target:delegateRoot
        property: "isTagged"
        value:delegateRoot.ListView.view.isSelectAll?true:delegateRoot.ListView.view.getNewStatus(index)
        when:delegateRoot.ListView.view.onIsSelectAllChanged
    }

    Connections{
        target: delegateRoot.ListView.view
        onCurDragItemChanged:{
            //console.log("onCurDragItemChanged in delegate:",curIndex,index)
            if(curIndex != index && isExclusive)
            {
                toInitState()
            }
        }
    }

    Connections{
        target: delegateRoot.ListView.view
        onResetDelegateState:{
            toInitState()
        }
    }

}
