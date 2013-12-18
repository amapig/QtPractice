import QtQuick 2.0
import QtQuick.Controls 1.0
import com.nokia.meego 2.0
import QtQuick.Controls.Styles 1.0
import com.cmos.widget 1.0

PageStackWindow{

    property alias langPath: transId.path
    property alias appName: transId.name
    property alias transflag: transId.transflag
    property bool keyHandle: true

    signal langChanged()

    onLangChanged: {
        console.log("lang changed")
    }

    CmosTranslate{
        id: transId
        //path: ""
        //name: ""
        Component.onCompleted: {
            trans();
             }

    }

    Keys.onReleased: {
        if (event.key == Qt.Key_Back && keyHandle) {
            if(pageStack.depth > 1)
                pageStack.pop();
            else
                Qt.quit();
        }
    }

    Component.onCompleted: {
             transId.langChanged.connect(langChanged)
         }
}
