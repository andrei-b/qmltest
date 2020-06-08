import CPPListElement 1.0
import CPPListModel 1.0
import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    visible: true
    title: qsTr("QML Test")

    Item {
        width: 200
        height: view.model.rowCount()*150
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
                    property bool expanded : true
                    Text {
                        id : ttext
                        anchors.verticalCenter: parent.verticalCenter
                        x: 30
                        font.pixelSize: 18
                        text: itemName
                    }
                    Bullet { }
                    ExpandButton {
                        visible: subItems == null ? false : subItems.rowCount() !== 0
                        property alias expanded : treeNode.expanded
                    }
                }

                Loader {
                    id: childItemLoader
                    x : 20
                    visible: treeNode.expanded
                    property variant subItemModel : items == null ? null : items.subItems(index)
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
                            border.width: 0
                            property bool expanded : false
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                x: 30
                                font.pixelSize: 18
                                text: itemName
                            }
                            Bullet { }
                            ExpandButton {
                                visible: items == null ? false : items.subItems(index).rowCount() !== 0
                                property alias expanded : subNode.expanded
                            }
                        }
                        Loader {
                            visible: subNode.expanded
                            property variant subItemModel : items == null ? null : items.subItems(index)
                            sourceComponent: !subNode.expanded ? null : subItemColumnDelegate
                            onStatusChanged: if (status == Loader.Ready) item.model = subItemModel
                        }
                    }
                }
            }
        }
    }
}
