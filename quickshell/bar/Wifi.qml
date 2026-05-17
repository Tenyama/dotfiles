import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io

Control {
    id: root

    padding: 0
    contentItem: RowLayout {
        spacing: 6

        Text {
            text: wifiIcon
            font.pixelSize: 16
            color: wifiConnected ? "#00ff00" : "#808080"
        }

        MouseArea {
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            cursorShape: Qt.PointingHandCursor
            onClicked: wifiPopup.visible = !wifiPopup.visible
        }
    }

    property string wifiIcon: "󰤟"
    property bool wifiConnected: false

    Popup {
        id: wifiPopup
        parent: Overlay.overlay
        modal: true
        focus: true

        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)

        width: 300
        height: 400

        background: Rectangle {
            color: "#0d0d14"
            border.color: "#1a1a1a"
            border.width: 1
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            Text {
                text: "WiFi Networks"
                font.pixelSize: 14
                font.bold: true
                color: "#ffffff"
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: "#1a1a1a"
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 4

                model: wifiModel

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 32
                    color: wifiMouse.containsMouse ? "#1a1a1a" : "transparent"

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8

                        Text {
                            text: modelData.inUse ? "󰒓" : modelData.signal > 70 ? "󰒄" : modelData.signal > 40 ? "󰒂" : "󰒀"
                            font.pixelSize: 14
                            color: modelData.inUse ? "#00ff00" : "#808080"
                        }

                        Text {
                            text: modelData.ssid
                            font.pixelSize: 12
                            color: "#ffffff"
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                        }

                        Text {
                            text: modelData.secured ? "🔒" : ""
                            font.pixelSize: 12
                            visible: modelData.secured
                        }
                    }

                    MouseArea {
                        id: wifiMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (modelData.secured && !modelData.inUse) {
                                wifiConnectProc.command = [
                                    "sh", "-c",
                                    "pass=$(zenity --password --title='Connect to " + modelData.ssid + "') && [ -n \"$pass\" ] && nmcli dev wifi connect \"" + modelData.ssid + "\" password \"$pass\""
                                ]
                            } else if (!modelData.inUse) {
                                wifiConnectProc.command = ["nmcli", "dev", "wifi", "connect", modelData.ssid]
                            }
                            wifiConnectProc.running = true
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: wifiModel
    }

    Process {
        id: wifiScanProc
        command: ["sh", "-c", "nmcli -t -f IN-USE,SIGNAL,SECURITY,SSID dev wifi"]
        stdout: SplitParser {
            onRead: data => {
                let f1 = data.indexOf(":")
                let f2 = data.indexOf(":", f1 + 1)
                let f3 = data.indexOf(":", f2 + 1)
                if (f1 > 0 && f2 > 0 && f3 > 0) {
                    let inUse = data.substring(0, f1) === "*"
                    let signal = parseInt(data.substring(f1 + 1, f2))
                    let sec = data.substring(f2 + 1, f3)
                    let ssid = data.substring(f3 + 1).replace(/\\\\:/g, ':')
                    if (ssid.length > 0) {
                        let exists = false
                        for (let i = 0; i < wifiModel.count; i++) {
                            if (wifiModel.get(i).ssid === ssid) {
                                exists = true
                                break
                            }
                        }
                        if (!exists) {
                            wifiModel.append({
                                inUse: inUse,
                                signal: signal,
                                secured: (sec.length > 0 && sec !== "--"),
                                ssid: ssid
                            })
                        }
                    }
                }
            }
        }
    }

    Process {
        id: wifiConnectProc
        onExited: {
            wifiModel.clear()
            wifiScanProc.running = true
        }
    }

    Timer {
        interval: 5000
        running: wifiPopup.visible
        repeat: true
        onTriggered: {
            wifiModel.clear()
            wifiScanProc.running = true
        }
    }

    Component.onCompleted: {
        wifiScanProc.running = true
    }
}
