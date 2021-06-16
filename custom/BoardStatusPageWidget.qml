/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.3
import QtQuick.Controls 1.2

import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.Controllers   1.0
import QGroundControl.Palette       1.0
import QGroundControl               1.0

Rectangle {
    height: coverColumn.y + coverColumn.height + 5
    width:  pageWidth
    color:  qgcPal.window

    property bool showSettingsIcon: false

    property var    _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle ? QGroundControl.multiVehicleManager.activeVehicle : QGroundControl.multiVehicleManager.offlineEditingVehicle

    QGCPalette { id:qgcPal; colorGroupEnabled: true }

    Column{
        id: coverColumn
        x: parent.x + 10
        y: parent.y + 5
        width: parent.width/2
        spacing: 8

        Row{
            spacing: 8
            Rectangle{
                height: 15; width: 15
                color: _activeVehicle.boardstatus.ARM1? "green": "gray"
                radius: 2
                anchors.verticalCenter: parent.verticalCenter
            }

            QGCLabel {
                text:   qsTr("ARM 1")
            }
        }

        Row{
            spacing: 8
            Rectangle{
                height: 15; width: 15
                color: _activeVehicle.boardstatus.MASS_SHIFTER? "green": "gray"
                radius: 2
                anchors.verticalCenter: parent.verticalCenter
            }

            QGCLabel {
                text:   qsTr("Mass Shifter")
            }
        }

        Row{
            spacing: 8
            Rectangle{
                height: 15; width: 15
                color: _activeVehicle.boardstatus.THRUSTER? "green": "gray"
                radius: 2
                anchors.verticalCenter: parent.verticalCenter
            }

            QGCLabel {
                text:   qsTr("Thruster")
            }
        }
    }

    Column{
        x: parent.width/2 + 10
        y: parent.y + 5
        width: parent.width/2
        spacing: 8

        Row{
            spacing: 8
            Rectangle{
                height: 15; width: 15
                color: _activeVehicle.boardstatus.ARM2? "green": "gray"
                radius: 2
                anchors.verticalCenter: parent.verticalCenter
            }

            QGCLabel {
                text:   qsTr("ARM 2")
            }
        }

        Row{
            spacing: 8
            Rectangle{
                height: 15; width: 15
                color: _activeVehicle.boardstatus.VIAM_NAVI? "green": "gray"
                radius: 2
                anchors.verticalCenter: parent.verticalCenter
            }

            QGCLabel {
                text:   qsTr("VIAM_NAVI")
            }
        }

        Row{
            spacing: 8
            Rectangle{
                height: 15; width: 15
                color: _activeVehicle.boardstatus.PISTOL? "green": "gray"
                radius: 2
                anchors.verticalCenter: parent.verticalCenter
            }

            QGCLabel {
                text:   qsTr("Pistol")
            }
        }
    }
} // Item
