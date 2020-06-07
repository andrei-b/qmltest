import QtQuick 2.0

Rectangle {
    width: 20
    height: 30
    anchors.right: parent.left
    anchors.leftMargin: 20
    anchors.verticalCenter: parent.verticalCenter
    Text {
        anchors.verticalCenter: parent.verticalCenter
        color : "blue"
        font.pixelSize: 18
        font.bold: true
        text: expanded ? "-" : "+"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: expanded = !expanded
    }
}
