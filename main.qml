import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.2
import "pages"

ApplicationWindow {
    id: window
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Stack")

    ///Commonstart
    property string version : "0.1.0"
    property string covidStartDate : "" // Start date for my corona
    property string covidEndDate : "" // End date for my corona
    property int minHits : 15 // minimum amount of hits to give exposure, related to discoveryTimer
    property int discoveryTimer : 60000 // discoveryTimer default value, discovered once per minute
    property string serverAddress : "172.28.172.3" //Default server address
    property int serverPort: 4243 // Default server port
    property string lastUsed : "" // To be utilized later to remove old data if the ap has been used seldom
    property int coronaExposureSince : -1 // Days from last corona exposure
    ///Commonend



    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Settings")
                width: parent.width
                onClicked: {
                    stackView.push("pages/Settings.qml")
                    drawer.close()
                    console.log(discoveryTimer)
                }
            }
            ItemDelegate {
                text: qsTr("About")
                width: parent.width
                onClicked: {
                    stackView.push("pages/About.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "pages/MainPage.qml"
        anchors.fill: parent
    }
}
