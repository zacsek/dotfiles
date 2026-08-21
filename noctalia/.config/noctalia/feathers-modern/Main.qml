import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: root
    width: 640
    height: 480
    color: "#010409"

    TextConstants { id: textConstants }

    Connections {
        target: sddm

        function onLoginSucceeded() {
            errorMessage.color = "#00CC88"
            errorMessage.text = textConstants.loginSucceeded
        }

        function onLoginFailed() {
            errorMessage.color = "#FF5555"
            errorMessage.text = textConstants.loginFailed
        }
    }

    Repeater {
        model: screenModel
        Background {
            x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
            source: Qt.resolvedUrl(config.background)
            fillMode: Image.PreserveAspectCrop
            onStatusChanged: {
                if (status == Image.Error && source != config.defaultBackground) {
                    source = config.defaultBackground
                }
            }
        }
    }

    Rectangle {
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
        color: "transparent"
        transformOrigin: Item.Top

        // Large Clock and Date at the top
        Column {
            id: clockArea
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.12
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            Text {
                id: timeLabel
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                font.pixelSize: 84
                font.weight: Font.DemiBold
                text: Qt.formatTime(new Date(), "hh:mm")
            }

            Text {
                id: dateLabel
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#E0E0E0"
                font.pixelSize: 18
                font.weight: Font.Normal
                text: Qt.formatDate(new Date(), "dddd, MMMM d")
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                timeLabel.text = Qt.formatTime(new Date(), "hh:mm")
                dateLabel.text = Qt.formatDate(new Date(), "dddd, MMMM d")
            }
        }

        // Modern Login Card
        Rectangle {
            id: loginCard
            anchors.centerIn: parent
            anchors.verticalCenterOffset: parent.height * 0.12
            width: 380
            height: 380
            color: "#CC111622" // Dark transparent surface
            radius: 16
            border.color: "#25FFFFFF" // Glass border
            border.width: 1

            // CachyOS Small logo at the top
            Image {
                id: logo
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                width: 48
                height: 48
                fillMode: Image.PreserveAspectFit
                source: "cachyos.png"
            }

            Column {
                anchors.top: logo.bottom
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 30
                anchors.rightMargin: 30
                spacing: 12

                // Username field
                Column {
                    width: parent.width
                    spacing: 4
                    Text {
                        text: textConstants.userName
                        color: "#88FFFFFF"
                        font.pixelSize: 11
                    }
                    TextBox {
                        id: name
                        width: parent.width; height: 36
                        color: "#1AFFFFFF"
                        borderColor: "#33FFFFFF"
                        textColor: "white"
                        focusColor: config.primaryColor
                        hoverColor: "#55FFFFFF"
                        radius: 8
                        text: userModel.lastUser

                        KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password

                        Keys.onPressed: function(event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, session.index)
                                event.accepted = true
                            }
                        }
                    }
                }

                // Password field
                Column {
                    width: parent.width
                    spacing: 4
                    Text {
                        text: textConstants.password
                        color: "#88FFFFFF"
                        font.pixelSize: 11
                    }
                    PasswordBox {
                        id: password
                        width: parent.width; height: 36
                        color: "#1AFFFFFF"
                        borderColor: "#33FFFFFF"
                        textColor: "white"
                        focusColor: config.primaryColor
                        hoverColor: "#55FFFFFF"
                        radius: 8
                        tooltipBG: "#161B22"

                        KeyNavigation.backtab: name; KeyNavigation.tab: session

                        Keys.onPressed: function(event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, session.index)
                                event.accepted = true
                            }
                        }
                    }
                }

                // Session & Layout choices in a row
                Row {
                    width: parent.width
                    spacing: 12
                    Column {
                        width: (parent.width - 12) / 2
                        spacing: 4
                        Text {
                            text: textConstants.session
                            color: "#88FFFFFF"
                            font.pixelSize: 11
                        }
                        ComboBox {
                            id: session
                            width: parent.width; height: 36
                            color: "#1AFFFFFF"
                            borderColor: "#33FFFFFF"
                            textColor: "white"
                            focusColor: config.primaryColor
                            hoverColor: "#55FFFFFF"
                            menuColor: "#161B22"
                            arrowIcon: "angle-down.png"

                            model: sessionModel
                            index: sessionModel.lastIndex

                            KeyNavigation.backtab: password; KeyNavigation.tab: layoutBox
                        }
                    }
                    Column {
                        width: (parent.width - 12) / 2
                        spacing: 4
                        Text {
                            text: textConstants.layout
                            color: "#88FFFFFF"
                            font.pixelSize: 11
                        }
                        LayoutBox {
                            id: layoutBox
                            width: parent.width; height: 36
                            color: "#1AFFFFFF"
                            borderColor: "#33FFFFFF"
                            textColor: "white"
                            focusColor: config.primaryColor
                            hoverColor: "#55FFFFFF"
                            menuColor: "#161B22"
                            arrowIcon: "angle-down.png"

                            KeyNavigation.backtab: session; KeyNavigation.tab: loginButton
                        }
                    }
                }

                // Error Message/Prompt
                Text {
                    id: errorMessage
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    text: textConstants.prompt
                    color: "#E0E0E0"
                    font.pixelSize: 11
                    wrapMode: Text.WordWrap
                }

                // Action buttons
                Row {
                    width: parent.width
                    spacing: 8
                    Button {
                        id: loginButton
                        text: textConstants.login
                        width: (parent.width - 16) / 2
                        height: 36
                        color: config.primaryColor
                        activeColor: Qt.lighter(config.primaryColor, 1.1)
                        pressedColor: Qt.darker(config.primaryColor, 1.2)
                        font.pixelSize: 13

                        onClicked: sddm.login(name.text, password.text, session.index)

                        KeyNavigation.backtab: layoutBox; KeyNavigation.tab: shutdownButton
                    }
                    Row {
                        width: (parent.width - 16) / 2
                        spacing: 8
                        Button {
                            id: shutdownButton
                            text: "Power"
                            width: (parent.width - 8) / 2
                            height: 36
                            color: "#25FFFFFF"
                            activeColor: "#50FFFFFF"
                            pressedColor: "#75FFFFFF"
                            font.pixelSize: 11

                            onClicked: sddm.powerOff()

                            KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
                        }
                        Button {
                            id: rebootButton
                            text: "Reboot"
                            width: (parent.width - 8) / 2
                            height: 36
                            color: "#25FFFFFF"
                            activeColor: "#50FFFFFF"
                            pressedColor: "#75FFFFFF"
                            font.pixelSize: 11

                            onClicked: sddm.reboot()

                            KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (name.text == "")
            name.focus = true
        else
            password.focus = true
    }
}
