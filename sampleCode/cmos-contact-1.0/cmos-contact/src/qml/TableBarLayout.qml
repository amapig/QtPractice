import QtQuick 2.0
import com.nokia.meego 2.0

ButtonRow {
    TabButton {
        iconSource:'image/tabbar/key2.png'
        onClicked:
        {
            if(main.pageStack.currentPage !== pDialPage) main.pageStack.replace(pDialPage);
        }
    }
    TabButton {
        iconSource:'image/tabbar/key2.png'
        onClicked:
        {
            if(main.pageStack.currentPage !== pHistoryPage) main.pageStack.replace(pHistoryPage);
        }
    }
    TabButton {
        iconSource:'image/tabbar/key2.png'
        onClicked:
        {
            if(main.pageStack.currentPage !== pHistoryPage) main.pageStack.replace(pHistoryPage);
        }
    }
    TabButton {
        iconSource:'image/tabbar/key2.png'
        onClicked:
        {
            if(main.pageStack.currentPage !== pHistoryPage) main.pageStack.replace(pHistoryPage);
        }
    }
}
