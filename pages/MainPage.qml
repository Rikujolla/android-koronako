import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.LocalStorage 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import harbour.koronako.koronascan 1.0
import harbour.koronako.koronaclient 1.0
import "./databases.js" as Mydb

Page {
    id: page

    property var messages: [{mesg:""},
        {mesg:qsTr("Not connected to server!")},
        {mesg:qsTr("Exposured!")},
        {mesg:qsTr("No exposure!")},
        {mesg:qsTr("Sent corona data!")},
        {mesg:qsTr("Wrong app version!")},
        {mesg:qsTr("Other error!")}
    ]

    width: Screen.width
    //height: Screen.height

    title: qsTr("Today")

    /*Label {
        text: qsTr("You are on the home page.")
        anchors.centerIn: parent
    }*/

    Flickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: page.width
            spacing: Screen.height/30
            leftPadding: Screen.width/30
            topPadding: Screen.height/30

            Label {
                font.bold: true
                text:qsTr("Phones close of my phone: %1").arg(koronaList.get(0).devices)
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        closeText.visible = !closeText.visible
                        Mydb.saveSettings(1)
                    }
                }
            }

            Text {
                id: closeText
                //font.pixelSize: Theme.fontSizeSmall
                //color: Theme.primaryColor
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: qsTr("Number of the phones the Koronako app has detected today close of your phone.")
            }

            Label {
                font.bold: true
                text: qsTr("Phone exposures: %1").arg(koronaList.get(0).exposures)
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        exposuresText.visible = !exposuresText.visible
                        Mydb.saveSettings(1)
                    }
                }
            }

            Text {
                id: exposuresText
                //font.pixelSize: Theme.fontSizeSmall
                //color: Theme.primaryColor
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: qsTr("Number of the those phones that have exceeded determined exposure time.")
            }

            Label {
                id:headDaysCorona
                font.bold: true
                text: qsTr("Days from last corona exposure: %1").arg(koronaList.get(0).coronaExposureSince < 0 ? "-" : koronaList.get(0).coronaExposureSince)
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        koronaExposuresText.visible = !koronaExposuresText.visible
                        Mydb.saveSettings(1)
                    }
                }
            }

            Text {
                id: koronaExposuresText
                //font.pixelSize: Theme.fontSizeSmall
                //color: Theme.primaryColor
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: qsTr("By sending your exposure data to the server, you can check if somebody has exposured you to coronavirus.")
            }

            Text {
                id: exposuresCheckedText
                //font.pixelSize: Theme.fontSizeSmall
                //color: Theme.primaryColor
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: qsTr("Exposures checked from server: %1").arg("NOT KNOWN")
            }

            Text {
                id: msgRow1
                visible:false
                //font.pixelSize: Theme.fontSizeSmall
                //color: Theme.primaryColor
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: ""
            }

            Button {
                id:checkMyKorona
                anchors.horizontalCenter: parent.horizontalCenter
                style: ButtonStyle {
                    label: Text{
                        text:qsTr("Check corona exposures")
                    }
                }
                onClicked: {
                    enabled = false;
                    msgRow1.visible = false
                    koronaClient.sport = serverPort
                    koronaClient.sipadd = serverAddress
                    koronaClient.exchangeDataWithServer(Mydb.checkMyExposures())
                }
            }


            Label {
                font.bold: true
                text: qsTr("My korona infection")
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        koronaDiseaseText.visible = !koronaDiseaseText.visible
                        Mydb.saveSettings(1)
                    }
                }
            }

            Text {
                id: koronaDiseaseText
                //font.pixelSize: Theme.fontSizeSmall
                //color: Theme.primaryColor
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: qsTr("By sending my corona infection dates and exposure data to the server, I will help others to prevent of spreading the disease.")
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    id: koronaStart
                    text: qsTr("Start date")
                    style: ButtonStyle {
                        label: Text{
                            text: koronaStart.text
                        }
                    }

                    onClicked: {
                        var dialog = stackView.push(pickerComponent, {
                                                    date: covidStartDate != "" ? covidStartDate : new Date('2020/06/01')
                                                })
                    dialog.clicked.connect(function() {
                        // Not accepting future date
                        if((new Date(dialog.selectedDate)-new Date())/24/3600/1000 >0.5){
                            covidStartDate = new Date()
                            koronaStart.text = new Date(covidStartDate).toLocaleDateString(Qt.locale(),Locale.ShortFormat)
                        }
                        // Start date cannot be newer than end date
                        else if((new Date(dialog.selectedDate)-new Date(covidEndDate))/24/3600/1000 >0.5){
                            covidStartDate = covidEndDate
                            koronaStart.text = new Date(covidStartDate).toLocaleDateString(Qt.locale(),Locale.ShortFormat)

                        }
                        else {
                            covidStartDate = dialog.selectedDate
                            koronaStart.text = new Date(covidStartDate).toLocaleDateString(Qt.locale(),Locale.ShortFormat)
                        }
                        Mydb.saveSettings(1);
                        stackView.pop()
                    })
                    }
                }

                Button {
                    id: koronaEnd
                    text: qsTr("End date")
                    style: ButtonStyle {
                        label: Text{
                            text: koronaEnd.text
                        }
                    }

                    onClicked: {
                        var dialog = stackView.push(pickerComponent, {
                                                    date: covidEndDate != "" ? covidEndDate : new Date()
                                                })
                    dialog.clicked.connect(function() {
                        // Not accepting future date
                        if((new Date(dialog.selectedDate)-new Date())/24/3600/1000 >0.5){
                            covidEndDate = new Date()
                            koronaEnd.text = new Date(covidEndDate).toLocaleDateString(Qt.locale(),Locale.ShortFormat)
                        }
                        // End day cannot be earlier than start date
                        else if ((new Date(dialog.selectedDate)-new Date(covidStartDate))/24/3600/1000 < 0.5) {
                            covidEndDate = covidStartDate
                            koronaEnd.text = new Date(covidStartDate).toLocaleDateString(Qt.locale(),Locale.ShortFormat)
                        }
                        else {
                            covidEndDate = dialog.selectedDate
                            koronaEnd.text = new Date(covidEndDate).toLocaleDateString(Qt.locale(),Locale.ShortFormat)
                        }
                        Mydb.saveSettings(1);
                        stackView.pop()
                    })
                    }
                }
            }

            Component {
            id: pickerComponent
            Calendar {}
        }

            Text {
                id: exposuresSentText
                //font.pixelSize: Theme.fontSizeSmall
                //color: Theme.primaryColor
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: qsTr("Infection data sent to the server: %1").arg("NOT KNOWN")
            }


            Button {
                id: sendMyKorona
                anchors.horizontalCenter: parent.horizontalCenter
                style: ButtonStyle {
                    label: Text{
                        text: qsTr("Send my infection data")
                    }
                }
                onClicked:{
                    enabled = false
                    koronaStart.enabled = false
                    koronaEnd.enabled = false
                    //Mydb.readMyKorona()
                    koronaClient.sport = serverPort
                    koronaClient.sipadd = serverAddress
                    //koronaClient.exchangeDataWithServer("MyKoronaData")
                    koronaClient.exchangeDataWithServer(Mydb.readMyKorona())
                }
            }

            Text {
                id: msgRow2
                visible:false
                //font.pixelSize: Theme.fontSizeSmall
                //color: Theme.primaryColor
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: ""
            }

        }

    }

    Timer{
        interval: discoveryTimer
        running: true
        repeat: true
        onTriggered: {
            Mydb.findHits(current_day());
            koronaScan.startScan();
            console.log("test")
        }
    }

    ListModel {
        id: koronaList
        ListElement {
            day:"today"
            devices: 0
            exposures: 0
            coronaExposureSince: -1
        }
    }

    Koronascan {
        id:koronaScan
        onBtDeviceChanged:{
            console.log("hits")
            Mydb.addHits(btDevice, btDevice.substring(0, 2))
        }
    }

    Koronaclient {
        id: koronaClient
        onKorodataChanged:  console.log(korodata, "test")
        onMsgChanged: {
            switch (msg) {
            case 1: // No connection to server
                if (checkMyKorona.enabled == false){
                    msgRow1.visible = true
                    msgRow1.text = qsTr("Exposure status: ") + messages[msg].mesg
                    checkMyKorona.enabled = true
                }
                else {
                    msgRow2.visible = true
                    msgRow2.text = qsTr("Data sent status: ") + messages[msg].mesg
                    sendMyKorona.enabled = true
                    koronaStart.enabled = true
                    koronaEnd.enabled = true
                }
                break;
            case 2: // Exposured
                msgRow1.visible = true
                msgRow1.text = qsTr("Exposure status: ") + messages[msg].mesg
                checkMyKorona.enabled = true
                exposuresCheckedText.text = qsTr("Exposures checked from server: %1").arg(new Date().toLocaleString(Qt.locale(),Locale.ShortFormat))
                break;
            case 3: // Not exposured
                msgRow1.visible = true
                msgRow1.text = qsTr("Exposure status: ") + messages[msg].mesg
                checkMyKorona.enabled = true
                exposuresCheckedText.text = qsTr("Exposures checked from server: %1").arg(new Date().toLocaleString(Qt.locale(),Locale.ShortFormat))
                break;
            case 4: //Data sent
                Mydb.removeMyKorona()
                msgRow2.visible = true
                msgRow2.text = qsTr("Data sent status: ") + messages[msg].mesg
                sendMyKorona.enabled = true
                koronaStart.enabled = true
                koronaEnd.enabled = true
                exposuresSentText.text = qsTr("Infection data sent to the server: %1").arg(new Date().toLocaleString(Qt.locale(),Locale.ShortFormat))
                break;
            case 5: // Wrong app version
                if (checkMyKorona.enabled == false){
                    msgRow1.visible = true
                    msgRow1.text = qsTr("Exposure status: ") + messages[msg].mesg
                    checkMyKorona.enabled = true
                }
                else {
                    msgRow2.visible = true
                    msgRow2.text = qsTr("Data sent status: ") + messages[msg].mesg
                    sendMyKorona.enabled = true
                    koronaStart.enabled = true
                    koronaEnd.enabled = true
                }
                break;
            default:
                break;
            }

        }
        onMsg2Changed: {
            if (msg2 > new Date().getDate()){
                //rough estimate
                koronaList.set(0,{"coronaExposureSince": new Date().getDate() + 31 - msg2})
            }
            else {
                koronaList.set(0,{"coronaExposureSince": new Date().getDate() - msg2})
            }

            headDaysCorona.text = qsTr("Days from last corona exposure: %1").arg(koronaList.get(0).coronaExposureSince < 0 ? "-" : koronaList.get(0).coronaExposureSince)
        }
    }


    property string current_date

    function current_day() {

        var d = new Date();
        var n = d.getDate()
        if (n < 10) {n = "0"+n}
        current_date = n
        return current_date
    }
    Component.onCompleted: {
        Mydb.findHits(current_day());
        koronaScan.ctime = discoveryTimer;
        Mydb.deleteOldData(current_day())
        Mydb.loadSettings()
        covidStartDate != "" ? koronaStart.text = new Date(covidStartDate).toLocaleDateString(Qt.locale(),Locale.ShortFormat) : koronaStart.text = qsTr("Start date")
        covidEndDate != "" ? koronaEnd.text = new Date(covidEndDate).toLocaleDateString(Qt.locale(),Locale.ShortFormat) : koronaEnd.text = qsTr("End date")
    }

}
