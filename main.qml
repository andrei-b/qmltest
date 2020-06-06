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
            model: nestedModel
            delegate: treeNodeDelegate
        }

        ListModel {
            id: nestedModel
            ListElement {
                categoryName: "Veggies"
                collapsed: true

                // A ListElement can't contain child elements, but it can contain
                // a list of elements. A list of ListElements can be used as a model
                // just like any other model type.
                subItems: [
                    ListElement { itemName: "Tomato" },
                    ListElement { itemName: "Cucumber" },
                    ListElement { itemName: "Onion" },
                    ListElement { itemName: "Brains" }
                ]
                subsubitems: [ListElement { itemName: "1" }]
            }

            ListElement {
                categoryName: "Fruits"
                collapsed: true
                subItems: [
                    ListElement { itemName: "Orange" },
                    ListElement { itemName: "Apple" },
                    ListElement { itemName: "Pear" },
                    ListElement { itemName: "Lemon" }
                ]
                subsubitems: [ListElement { itemName: "1" }]
            }

            ListElement {
                categoryName: "Cars"
                collapsed: true
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
                    height: 50
                    width: 200

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        x: 15
                        font.pixelSize: 24
                        text: categoryName
                    }

                    Rectangle {
                        visible: !(subItems==null)
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
                        text: !collapsed ? "-" : "+"
                    }
                        MouseArea {
                            anchors.fill: parent

                            // Toggle the 'collapsed' property
                            onClicked: nestedModel.setProperty(index, "collapsed", !collapsed)
                        }
                    }
                }

                Loader {
                    id: childItemLoader
                    x : 20
                    // This is a workaround for a bug/feature in the Loader element. If sourceComponent is set to null
                    // the Loader element retains the same height it had when sourceComponent was set. Setting visible
                    // to false makes the parent Column treat it as if it's height was 0.
                    visible: !collapsed
                    property variant subItemModel : subItems
                    sourceComponent: collapsed ? null : subItemColumnDelegate
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
                Repeater {
                    id: subItemRepeater

                     delegate: Column {
                        width:200
                        Rectangle {
                            height: 40
                            width: 200
                            color: "#ccccff"
                            border.color: "blue"
                            border.width: 1
                            Text {
                            anchors.verticalCenter: parent.verticalCenter
                            x: 30
                            font.pixelSize: 18
                            text: itemName
                        }
                            Rectangle {
                                visible: !(subItems==null)
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
                                text: expanded ? "-" : "+"
                            }
                                MouseArea {
                                    anchors.fill: parent

                                    // Toggle the 'collapsed' property
                                    onClicked: item.model.setProperty(index, "expanded", !expanded)
                                }
                            }
                        }

                        Loader {
                            visible: expanded
                            property variant subItemModel : subItems
                            sourceComponent: subItems == null || !expanded ? null : subItemColumnDelegate
                            onStatusChanged: if (status == Loader.Ready) item.model = subItemModel
                        }

                        }

                }
            }
        }
    }
}
