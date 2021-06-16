import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs  1.2
import QtQuick.Layouts  1.2

import QGroundControl                       1.0
import QGroundControl.Controls              1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Palette               1.0
import QGroundControl.Controllers           1.0
import QGroundControl.FactSystem            1.0
import QGroundControl.FactControls          1.0

Item {
    id:         thrusterPage
    anchors.fill:               parent
    z:      5000

    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }

    property var _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle

    /// Thruster Status
    property real _dutyCycle:   _activeVehicle.thrusterDuty
    property real _rSpeed:      _activeVehicle.thrusterRSpeed
    property real _current:      _activeVehicle.thrusterCurrent
    property real _dSpeed:      _activeVehicle.thrusterDSpeed
    property real _tempOnChip:  _activeVehicle.thrusterTempOnChip
    property real _tempMotor:   _activeVehicle.thrusterTempAmbient

    property bool _visibleDialogDutyCycle: false
    property int precision: 2

    Rectangle{
        id: rectangle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: ScreenTools.defaultFontPixelWidth * 27
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:    ScreenTools.defaultFontPixelWidth + 2
        width: 320; height: 166
        border.color: "white"
        radius: 8
        color: "#801F1F1F"

        Rectangle{
            id: coverSpeedMeter
            x: 8; y: 8
            width: 149; height: 149
            color: "transparent"

            SpeedMeter {
                id: id_speed
                anchors.fill: coverSpeedMeter
                value:  _rSpeed
            }
        }

        Rectangle{
            id: statusThruster
            x: parent.width/2 - 30; y: 8
            width: 149; height: 149
            color: "transparent"
            Column{
                spacing: 2

                QGCLabel {
                    id: thrusterStatusText
                    x: statusThruster.width/2 - 40
                    text:           qsTr("Thruster Status")
                    font.family:    ScreenTools.normalFontFamily
                    font.bold:      true
                    font.pointSize:      12
                }

                Column{
                    x: statusThruster.width/2 - 80
                    y: 6
                    spacing: 3

                    QGCLabel {
                        x: statusThruster.width/2 - 45
                        text:           qsTr("Duty Cycle: ") + _dutyCycle.toFixed(precision) + qsTr(" %")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10

//                        MouseArea {
//                            id: mouseClicked
//                            anchors.fill:       parent
//                            acceptedButtons:    Qt.LeftButton
//                            onClicked: {
//                                _visibleDialogDutyCycle = editDialogDutyCycle(_visibleDialogDutyCycle)
//                            }

//                            function editDialogDutyCycle(_visible){
//                                return !_visible;
//                            }
//                        }
                    }

                    QGCLabel {
                        x: statusThruster.width/2 - 35
                        text:           qsTr("DSpeed: ") + _dSpeed.toFixed(precision) + qsTr(" RPM")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10
                    }

                    QGCLabel {
                        x: statusThruster.width/2 - 35
                        text:           qsTr("rSpeed: ") + _rSpeed.toFixed(precision) + qsTr(" RPM")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10
                    }

                    QGCLabel {
                        x: statusThruster.width/2 - 35
                        text:           qsTr("Current: ") + _current.toFixed(precision) + qsTr(" mA")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10
                    }

                    QGCLabel {
                        x: statusThruster.width/2 - 42
                        text:           qsTr("Temp on Chip: ") + _tempOnChip.toFixed(precision) + qsTr(" oC")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10
                    }

                    QGCLabel {
                        x: statusThruster.width/2 - 52
                        text:           qsTr("Temp Motor: ") + _tempMotor.toFixed(precision) + qsTr(" oC")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10
                    }
                }
            }
        }
    }

    Rectangle{
        id: dialogDutyCycle
        anchors.left: rectangle.right
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:    ScreenTools.defaultFontPixelWidth + 2
        width: 260; height: 166
        color: qgcPal.window
        visible:    _visibleDialogDutyCycle

        Rectangle{
            id: bar
            width: parent.width
            height: 35
            color:  qgcPal.windowShade

            Text {
                id: title
                height: parent.height
                width: 60
                anchors.left:       parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment:          Text.AlignVCenter
                horizontalAlignment:        Text.AlignLeft
                text: qsTr("Duty Cycle")
                color: "white"
                font.bold: true
                font.pointSize: 11
            }

            QGCButton{
                id: btnCancel
                height: parent.height
                width: 60
                anchors.right:       btnOK.left
                anchors.verticalCenter: parent.verticalCenter
                text:   qsTr("Cancel")

                onClicked: {
                    _visibleDialogDutyCycle = mouseClicked.editDialogDutyCycle(_visibleDialogDutyCycle)
                }
            }

            QGCButton{
                id: btnOK
                height: parent.height
                width: 60
                anchors.right:       parent.right
                anchors.verticalCenter: parent.verticalCenter
                text:   qsTr("Save")
                primary:        true

                onClicked: {
                    _dutyCycle = parseFloat(txtValue.text)
                    _activeVehicle.sendDutyCycle_MassShifter(_dutyCycle)
                }
            }

            Rectangle{
                anchors.top:    parent.top
                anchors.topMargin: 65
                width: parent.width
                color: "transparent"

                QGCTextField {
                    id:     txtValue
                    text:   _dutyCycle.toFixed(precision)
                    width:  parent.width
                    inputMethodHints:       Qt.ImhFormattedNumbersOnly
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    width: 50
                    anchors.right:       parent.right
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment:          Text.AlignVCenter
                    horizontalAlignment:        Text.AlignRight
                    text: qsTr("%")
                    color: "black"
                }
            }

            Rectangle{
                anchors.top:    parent.top
                anchors.topMargin: 110
                width: parent.width

                QGCLabel {
                    width:              parent.width - 10*2
                    anchors.centerIn: parent
                    wrapMode:           Text.WordWrap
                    text:               qsTr("- Set duty cylce for Thruster.\n- Range: 0-100%.")
                }
            }
        }
    }
}
