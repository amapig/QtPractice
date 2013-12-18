import QtQuick 2.0
import QtQuick.Controls 1.0
MouseArea {
    id:delegateRoot
    implicitHeight: 140
    implicitWidth: 300

    property bool canTag:true
    property bool canEdit:true
    property bool isEditing:false
    property bool isTagged:false
    property int tagTriggerMode:0 //0: press and hold  1:clicked

    property bool enableTag:true //tag will visible as needed,or never show
    property bool enableEdit:true //edit will visible as needed ,or new show

    property alias tagLd:tagLoader
    property alias editLd: editLoader

    signal deleteItem(int index) //-1:just delete single ,else index as index number in parent as ListView or gridview and soon

    property Component tagComponent:defaltTagCmp
    property Component editComponent:defaultEditCmp

    Component{
        id:defaltTagCmp
        CMOS_CheckBox{
            id:checkbox
            text:""
            lPadding:0
            checked: delegateRoot.isTagged
            source:checked?"images/icontagon.png":"images/icontagoff.png"
            onCheckedChanged: {
                delegateRoot.isTagged = checked
            }
            Binding{
                target: checkbox
                property:"checked"
                value:delegateRoot.isTagged
            }
        }
    }
    Component{
        id:defaultEditCmp
        CMOS_Button{
            id:editButton
            lMargin:0
            rMargin:0
            tMargin:0
            bMargin:0
            iconSource: "images/erase.png"
            onClicked:delegateRoot.deleteItem(index==undefined?-1:index) //for use in delegate
        }
    }

    onPressAndHold: {
        if(enableEdit && canEdit)
        {
            isEditing = !isEditing
        }
        else if(enableTag && canTag)
        {
            if(tagTriggerMode == 0)
            {
                isTagged = !isTagged
            }
        }

    }
    onClicked: {
        if(canEdit &&!isEditing || !canEdit){
            if(canTag && tagTriggerMode == 1)
            {
                isTagged = !isTagged
            }
        }
    }

    Loader{
        id:tagLoader
        visible: enableTag&&((canEdit && isEditing)||(canTag&&isTagged))
        sourceComponent: tagComponent
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        z:parent.z+1
    }
    Loader{
        id:editLoader
        visible: enableEdit && canEdit && isEditing
        sourceComponent: editComponent
        anchors.verticalCenter: parent.top
        anchors.horizontalCenter: parent.right
        z:parent.z+1
    }


}
