import Qt 4.7

Rectangle {
    color: "#343434";
    smooth: true;

    Image {
        smooth: true;
        source: "images/stripes.png";
        fillMode: Image.Tile;
        anchors.fill: parent;
        opacity: 0.4;
    }
}
