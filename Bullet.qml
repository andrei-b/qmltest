import QtQuick 2.0

Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    x:0
    y:0
    width: 20
    height: 20
    color: items == null ? "blue" : items.subItem(index).rowCount() !== 0 ? "red" : "blue"
}
