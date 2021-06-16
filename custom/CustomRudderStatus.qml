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
    id:         rudderPage
    anchors.fill:               parent
    z:      5000

    property var _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle

    /// Rudder Status
    property real _position:   _activeVehicle.rudderPosition
    property real _speed:      _activeVehicle.rudderSpeed
    property real _temperature:     _activeVehicle.rudderTemperature
    property real _voltage:  _activeVehicle.rudderVoltage
    property real _load:   _activeVehicle.rudderLoad

    property int precision: 2

    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }

    Rectangle{
        id: rectangle
        anchors.left: parent.left
        anchors.leftMargin: ScreenTools.defaultFontPixelWidth * 2.5
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:    ScreenTools.defaultFontPixelWidth + 180
        width: 260; height: 150
        border.color: "white"
        radius: 8
        color: "#801F1F1F"

        Rectangle{
            id: coverRudderMeter
            anchors.left: parent.left
            anchors.leftMargin: ScreenTools.defaultFontPixelWidth  + 2
            anchors.bottom:         parent.bottom
            anchors.bottomMargin:    ScreenTools.defaultFontPixelWidth + 2
            width: 130; height: 130
            color: "transparent"

            RudderMeter {
                id: id_speed
                anchors.fill: parent
                value:  _position.toFixed(precision)
            }
        }

        Rectangle{
            id: coverStatus
            x: parent.width/2 - 30
            anchors{
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }

            width: 149; height: 149
            color: "transparent"

            Column{
                spacing: 6
                anchors.top: parent.top
                anchors.topMargin: 10
                QGCLabel {
                    id: rudderStatusText
                    x: coverStatus.width/2 - 35
                    text:           qsTr("Rudder Status")
                    font.family:    ScreenTools.normalFontFamily
                    font.bold:      true
                    font.pointSize:      10
                }

                Column{
                    spacing: 6

                    QGCLabel {
                        x: coverStatus.width/2 - 42
                        text:           qsTr("Speed: ") + _speed.toFixed(precision) + qsTr(" RPM")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10
                    }
                    QGCLabel {
                        x: coverStatus.width/2 - 35
                        text:           qsTr("Temp: ") + _temperature.toFixed(precision) + qsTr(" oC")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10
                    }
                    QGCLabel {
                        x: coverStatus.width/2 - 35
                        text:           qsTr("Voltage: ") + _voltage.toFixed(precision) + qsTr(" V")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10
                    }
                    QGCLabel {
                        x: coverStatus.width/2 - 42
                        text:           qsTr("Load: ") + _load.toFixed(precision) + qsTr(" N.m")
                        font.family:    ScreenTools.normalFontFamily
                        font.pointSize:      10
                    }
                }
            }
        }
    }
}
