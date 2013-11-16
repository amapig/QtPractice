import Qt 4.7

QtObject {
    property variant currentValue
    default property ListModel model

    function currentIndex() {
        for (var i = 0; i < model.count; i++) {
            if (model.get(i).value == currentValue) {
                return i;
            }
        }

        return 0;
    }
}

