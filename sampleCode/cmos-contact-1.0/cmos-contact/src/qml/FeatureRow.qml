import QtQuick 2.0
import com.nokia.meego 2.0

Item{


    Image {
        id:keyPadShow
        fillMode: Image.PreserveAspectFit
        width: parent.width/4
        source:'image/featureicon/iconshouqi.png'
        anchors{
            left:parent.left
           // leftMargin: 98
            verticalCenter: parent.verticalCenter
        }
        Rectangle{
            id:pressedPadShow
            anchors.fill:parent
            color:"white"
            opacity: 0.5
            visible: false
        }

        MouseArea {
            anchors.fill:parent

            onClicked: {
                //contactListModel.requiredProperty = 2;
                parent.parent.state = "hide";

                //pageStack.push(Qt.resolvedUrl("ContactListPage.qml"), {pPreviousPage: root })
                //visible: false

            }
            onPressed: {
                   pressedPadShow.visible=true;
            }
            onReleased:{
                pressedPadShow.visible=false;
            }
        }
    }

    Image {
        id:keyPadHide
        anchors{
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        source:'image/featureicon/iconzhankai.png'
        visible: false

        Rectangle{
            id:pressedPadHide
            anchors.fill:parent
            color:"white"
            opacity: 0.5
            visible: false
        }
        MouseArea {
            anchors.fill:parent

            onClicked: {                
                parent.parent.state = "show";
            }
            onPressed: {
                   pressedPadHide.visible=true;
            }
            onReleased:{
                pressedPadHide.visible=false;
            }

        }
    }
    Image {
        id:keyCall
        width: parent.width/2
        fillMode: Image.PreserveAspectFit
        source:'image/featureicon/iconcall.png'
        anchors{
            left:keyPadShow.right
         //   leftMargin: 50
            top:parent.top
            topMargin: 10
        }

        Rectangle{
            id:pressedCall
            anchors.fill:parent
            color:"white"
            opacity: 0.5
            visible: false
        }

        MouseArea {
            anchors.fill:parent

            onClicked: {
                //contactListModel.requiredProperty = 2;
                //pageStack.push(Qt.resolvedUrl("ContactListPage.qml"), {pPreviousPage: root })

            }

            onPressed: {
                pressedCall.visible=true;
            }
            onReleased:{
                pressedCall.visible=false;
            }
        }
    }


    Image {
        id:keyBackspace
        width: parent.width/4
        fillMode: Image.PreserveAspectFit
        anchors{
            left:keyCall.right
           // leftMargin: 50
            verticalCenter:  parent.verticalCenter
        }
        source:'image/featureicon/iconback.png'

        Rectangle{
            id:pressedBackspace
            anchors.fill:parent
            color:"white"
            opacity: 0.5
            visible: false
        }


        MouseArea {
            anchors.fill:parent

            onClicked: numentry.backspace();
            onPressAndHold: {
                pressedBackspace.visible=true;
                numentry.clear();
            }
            onPressed: {
                pressedBackspace.visible=true;
            }
            onReleased:{
                pressedBackspace.visible=false;
            }
        }
    }

    states:[
        State{
            name:"show"
            PropertyChanges { target: keyPadShow; visible:true }
            PropertyChanges { target: keyCall; visible:true }
            PropertyChanges { target: keyBackspace; visible:true }
            PropertyChanges { target: keyPadHide; visible:false }
            PropertyChanges { target: numpad; height:childrenRect.height }
            PropertyChanges { target: numpad;visible:true}
            PropertyChanges { target: numberBorder;visible:true}
            PropertyChanges { target: numentry;visible:true}
            PropertyChanges { target: numentry; y:50}


        },
        State{
            name:"hide"
            PropertyChanges { target: keyPadShow; visible:false }
            PropertyChanges { target: keyCall; visible:false }
            PropertyChanges { target: keyBackspace; visible:false }
            PropertyChanges { target: keyPadHide; visible:true }
            PropertyChanges { target: numpad; height:0 }
            PropertyChanges { target: numentry;visible:true}
            PropertyChanges { target: numpad; visible:false}
            PropertyChanges { target: numberBorder;visible:false}
            PropertyChanges { target: numentry;y:-65}

        }
    ]

    state:"show"
    transitions: [
        Transition {
            from: "show"; to: "hide"



                SequentialAnimation {

                    PropertyAnimation {
                        target: keyPadShow
                        properties: "visible"; duration: 0

                    }
                    PropertyAnimation {
                        target: keyCall
                        properties: "visible"; duration: 0

                    }
                    PropertyAnimation {
                        target: keyBackspace
                        properties: "visible"; duration: 0

                    }
                    ParallelAnimation{
                        PropertyAnimation {
                             target: numpad
                             properties: "height"; easing.type: Easing.InOutExpo; duration: 50
                        }

                        PropertyAnimation {
                             target: numentry
                             properties: "y"; easing.type: Easing.InOutExpo; duration: 50
                        }
                    }

                    PropertyAnimation {
                        target: numpad
                        properties: "visible"; duration: 10

                    }
                    PropertyAnimation {
                        target: keyPadHide
                        properties: "visible"; duration: 10

                    }
                }
            },

        Transition {
            from: "hide"; to: "show"


                SequentialAnimation {


                    PropertyAnimation {
                        target: keyPadHide
                        properties: "visible"; duration: 0

                    }
                    PropertyAnimation {
                        target: numpad
                        properties: "visible"; duration: 0

                    }

                    ParallelAnimation{
                        PropertyAnimation {
                             target: numpad
                             properties: "height"; easing.type: Easing.InOutExpo; duration: 50
                        }

                        PropertyAnimation {
                             target: numentry
                             properties: "y"; easing.type: Easing.InOutExpo; duration: 50
                        }
                    }


                    PropertyAnimation {
                        target: keyPadShow
                        properties: "visible"; duration: 10

                    }
                    PropertyAnimation {
                        target: keyCall
                        properties: "visible"; duration: 10

                    }
                    PropertyAnimation {
                        target: keyBackspace
                        properties: "visible"; duration: 10

                    }
                }
            }
    ]

}
