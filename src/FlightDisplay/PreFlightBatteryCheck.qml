/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick 2.3

import QGroundControl           1.0
import QGroundControl.Controls  1.0
import QGroundControl.Vehicle   1.0

// This class stores the data and functions of the check list but NOT the GUI (which is handled somewhere else).
PreFlightCheckButton {
    name:                           qsTr("Battery")
    manualText:                     qsTr("Battery connector firmly plugged?")
    telemetryFailure:               _batHeadLow&_batMotorLow&_batTailLow
    telemetryTextFailure:           allowTelemetryFailureOverride ?
                                        qsTr("Warning - Battery charge below %1%.").arg(failurePercent) :
                                        qsTr("Battery charge below %1%. Please recharge.").arg(failurePercent)
    allowTelemetryFailureOverride:  allowFailurePercentOverride

    property int    failurePercent:                 40
    property bool   allowFailurePercentOverride:    false

    property var _activeVehicle:        QGroundControl.multiVehicleManager.activeVehicle
    property var _batHeadPercentRemaining:  _activeVehicle ? _activeVehicle.battery1.percentRemaining.value : 0
    property bool _batHeadLow:              _batHeadPercentRemaining < failurePercent
    property var _batMotorPercentRemaining:  _activeVehicle ? _activeVehicle.battery2.percentRemaining.value : 0
    property bool _batMotorLow:              _batMotorPercentRemaining < failurePercent
    property var _batTailPercentRemaining:  _activeVehicle ? _activeVehicle.battery3.percentRemaining.value : 0
    property bool _batTailLow:              _batTailPercentRemaining < failurePercent
}
