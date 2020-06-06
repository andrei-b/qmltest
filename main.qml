import CPPListElement 1.0
import CPPListModel 1.0
import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QML Test")
    Item {
        width: 200
        height: 300

        ListView {
            anchors.fill: parent
            model: treeModel//nestedModel
            delegate: treeNodeDelegate
        }

        ListModel {
            id: nestedModel
            ListElement {
                itemName: "Veggies"
                expanded: true

                // A ListElement can't contain child elements, but it can contain
                // a list of elements. A list of ListElements can be used as a model
                // just like any other model type.
                subItems: [
                    ListElement { itemName: "Tomato" },
                    ListElement { itemName: "Cucumber" },
                    ListElement { itemName: "Onion" },
                    ListElement { itemName: "Brains" }
                ]
            }

            ListElement {
                itemName: "Fruits"
                expanded: true
                subItems: [
                    ListElement { itemName: "Orange" },
                    ListElement { itemName: "Apple" },
                    ListElement { itemName: "Pear" },
                    ListElement { itemName: "Lemon" }
                ]
            }

            ListElement {
                itemName: "Cars"
                expanded: false
                subItems: [
                    ListElement { itemName: "Nissan"
                        expanded: true
                        subItems: [ListElement {
                                expanded: true
                                itemName: "4"
                                subItems: [ListElement {
                                        expanded: true
                                        itemName: "ZZ"
                                    },
                                ListElement {
                                        expanded: true
                                        itemName: "YY"
                                    }]
                            }]
                    },
                    ListElement { itemName: "Toyota"
                        expanded: true
                    subItems: [ListElement {
                            expanded: true
                            itemName: "1"
                        }]
                    },
                    ListElement {
                        itemName: "Chevy"
                        expanded: true
                    subItems: [ListElement {
                            expanded: true
                            itemName: "2" }]},
                    ListElement { itemName: "Audi"
                        expanded: true
                    subItems: [ListElement {
                            expanded: true
                            itemName: "3"
                            subItems: [ListElement {
                                    expanded: true
                                    itemName: "Z1"
                                },
                            ListElement {
                                    expanded: true
                                    itemName: "Y1"
                                }]
                        }]}
                ]

            }
        }

        Component {
            id: treeNodeDelegate
            Column {
                width: 200

                Rectangle {
                    id: treeNode
                    border.color: "blue"
                    border.width: 1
                    color: "white"
                    x: 20
                    height: 40
                    width: 200
                    property bool expanded : true
                    Text {
                        id : ttext
                        anchors.verticalCenter: parent.verticalCenter
                        x: 15
                        font.pixelSize: 18
                        text: itemName
                    }

                    Rectangle {
                        visible: subItems.rowCount() != 0
                        //color: "red"
                        width: 20
                        height: 30
                        anchors.left: parent.left
                        anchors.leftMargin: -20
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

                            // Toggle the 'collapsed' property
                            onClicked: expanded = !expanded //nestedModel.setProperty(index, "expanded", !expanded)
                        }
                    }
                }

                Loader {
                    id: childItemLoader
                    x : 20
                    // This is a workaround for a bug/feature in the Loader element. If sourceComponent is set to null
                    // the Loader element retains the same height it had when sourceComponent was set. Setting visible
                    // to false makes the parent Column treat it as if it's height was 0.
                    visible: expanded
                    property variant subItemModel : subItems
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
                property var items: model

                Repeater {
                    id: subItemRepeater

                     delegate: Column {
                        width:200

                        Rectangle {
                            id : subNode
                            height: 40
                            width: 200
                            color: "#ccccff"
                            border.color: "blue"
                            border.width: 1
                            property bool expanded : false

                            Text {
                            anchors.verticalCenter: parent.verticalCenter
                            x: 30
                            font.pixelSize: 18
                            text: itemName
                        }
                            Rectangle {
                                visible: items.subItem(index).rowCount() != 0
                                //color: "red"
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
                                text: subNode.expanded ? "-" : "+"
                            }
                                MouseArea {
                                    anchors.fill: parent

                                    // Toggle the 'collapsed' property
                                    onClicked: subNode.expanded = !subNode.expanded
                                }
                            }
                        }

                        Loader {
                            visible: subNode.expanded
               property variant subItemModel : items.subItem(index)
                            sourceComponent: !subNode.expanded ? null : subItemColumnDelegate
                            onStatusChanged: if (status == Loader.Ready) item.model = subItemModel
                        }

                        }

                }
            }
        }
    }
}
