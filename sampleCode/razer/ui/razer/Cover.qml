import Qt 4.7

Rectangle {
    property alias image: coverImage.source;

    width: 96;
    height: 96;

    Image {
        id: coverImage;
        source: "file"
    }

}
