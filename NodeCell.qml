import QtQuick 2.0

Rectangle {
    id: cell
    height: 40
    width: 200
    border.width: 0
    property bool expanded: false
    Text {
        anchors.verticalCenter: parent.verticalCenter
        x: 30
        font.pixelSize: 18
        text: itemName
    }
    ExpandButton {
        visible: items == null ? false : items.subItem(index).rowCount() !== 0
        property alias expanded : cell.expanded
    }
}
