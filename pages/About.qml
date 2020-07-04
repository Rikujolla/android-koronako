/*Copyright (c) 2020, Riku Lahtinen
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.2

Page {
    id: page

    title: qsTr("About page")

    Flickable {
        anchors.fill: parent

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Screen.height/30
            topPadding: Screen.height/30
            leftPadding: Screen.width/30
            Image {
                id: logo
                source: "./images/harbour-koronako.png"
                anchors.horizontalCenter: parent.horizontalCenter
                height: Screen.width/7
                width: Screen.width/7
            }

            Label {
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                //: The name of the app followed with a version number
                text: {qsTr("Koronako, version") + " " + version}
            }

            Label {
                font.bold: true
                text: qsTr("Idea")
            }
            Text {
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: {
                    qsTr("The idea of the software is to scan devices with bluetooth to help determine possible coronavirus exposures.")
                            + qsTr(" In addition of the app a proper server application (koronako-server) is needed.")
                }
            }

            Label {
                font.bold: true
                text: qsTr("Privacy")
            }
            Text {
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: {
                    qsTr("The basic idea to maintain your and others privacy is a symmetric device name mix of the devices.")
                            + qsTr(" Because only part of the device name is used false alarms are possible occasionally.")
                            +"\n" + qsTr("Only mixed device names and a month day number is saved to the database preventing data hacking later.")
                            + qsTr(" Nor more than one month data can be saved.")
                            +"\n" + qsTr("Paired devices are not saved to database. The major privacy concern is the requirement to have bluetooth on revealing your device to others.")
                }
            }

            Label {
                font.bold: true
                text: qsTr("Translations")
            }
            Text {
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: {
                    qsTr("Finnish (Riku Lahtinen)")
                }
            }

            Label {
                font.bold: true
                text: qsTr("Contributions")
            }
            Text {
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: {
                    qsTr("App icon (Riku Lahtinen)")
                            + "\n" + qsTr("Android device list from wikipedia.")
                }
            }

            Label {
                font.bold: true
                text: qsTr("Licence")
            }
            Text {
                wrapMode: Text.WordWrap
                width: root.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Screen.width/30
                }
                text: qsTr("Copyright (c) 2020, Riku Lahtinen") + "\n"
                      + qsTr("Licensed under BSD. License, source code and more information:") + "\n"
                      + ("https://github.com/Rikujolla/android-koronako")
            }
        }
    }
}

