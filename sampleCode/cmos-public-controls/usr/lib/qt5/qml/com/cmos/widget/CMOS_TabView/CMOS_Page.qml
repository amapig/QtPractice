import QtQuick 2.0
import QtQuick.Controls 1.0
import com.nokia.meego 2.0
import QtQuick.Controls.Styles 1.0
import com.cmos.widget 1.0

Page{
    UIConst{
        id: constUi
    }
    property real  factor: constUi.getValue("scale")
    width: 720
    height: 1280

    scale: factor
    transformOrigin: Item.TopLeft
}
