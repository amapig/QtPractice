import QtQuick 2.0
import com.cmos.widget 1.0

Rectangle {
    width: 1080
    height: 1920

    CMOS_ConfirmDialog{
        anchors.centerIn: parent
        title:"确定删除选中视频?"

        onRejected: {

        }

        onAccepted: {

        }

    }

}

