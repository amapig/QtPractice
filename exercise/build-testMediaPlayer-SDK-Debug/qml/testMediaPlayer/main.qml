/*!
 * Author: Mengcong
 * Date: 2013.11.19
 * Details: Entrance of the player.
 */

import QtQuick 2.0
import com.cmos.widget 1.0
import com.nokia.meego 2.0

PageStackWindow {
    id: root

    initialPage: PlayingInterface {
        width: parent.width
        height: parent.height

        filename: "/home/skytree/nuoyafangzhou.mp4"
    }
}
