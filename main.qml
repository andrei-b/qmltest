import CPPListElement 1.0
import CPPListModel 1.0
import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    visible: true
    width: 800
    height: 600
    title: qsTr("QML Test")

    Item {
        width: 200
        height: 300

        ListView {
            id : view
            anchors.fill: parent
            model: treeModel
            delegate: treeNodeDelegate
        }

        Component {
            id: treeNodeDelegate
            Column {
                width: 200
                property CPPListModel items: view.model
                Rectangle {
                    id: treeNode
                    //border.color: "white"
                    border.width: 0
                    //color: "white"
                    x: 20
                    height: 40
                    width: 200
                    Path {

                        startX: 0; startY: 0
                        PathLine { x: 200; y: 0 }
                    }
                    property bool expanded : true
                    Text {
                        id : ttext
                        anchors.verticalCenter: parent.verticalCenter
                        x: 15
                        font.pixelSize: 18
                        text: itemName
                    }
                    ExpandButton {
                        visible: subItems.rowCount() !== 0
                        property alias expanded : treeNode.expanded
                    }
                }

                Loader {
                    id: childItemLoader
                    x : 20
                    visible: treeNode.expanded
                    property variant subItemModel : items.subItem(index)
                    sourceComponent: !expanded ? null : subItemColumnDelegate
                    onStatusChanged: if (status == Loader.Ready) item.model = subItemModel
                }
            }

        }
        Component {
            id: subItemColumnDelegate
            Column {
                x : 40
                property alias model : subItemRepeater.model
                width: 200
                property CPPListModel items: model
                Repeater {
                    id: subItemRepeater
                    delegate: Column {
                        width:200
                        Rectangle {
                            id : subNode
                            height: 40
                            width: 200
                            //color: "#ccccff"
                            //border.color: "blue"
                            border.width: 0
                            property bool expanded : false
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                x: 30
                                font.pixelSize: 18
                                text: itemName
                            }
                            ExpandButton {
                                visible: items == null ? false : items.subItem(index).rowCount() !== 0
                                property alias expanded : subNode.expanded
                            }
                        }
                        Loader {
                            visible: subNode.expanded
                            property variant subItemModel : items == null ? null : items.subItem(index)
                            sourceComponent: !subNode.expanded ? null : subItemColumnDelegate
                            onStatusChanged: if (status == Loader.Ready) item.model = subItemModel
                        }
                    }
                }
            }
        }
    }
}
