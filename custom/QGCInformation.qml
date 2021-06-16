/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.3
import QtQuick.Layouts  1.11

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.Palette       1.0
import QGroundControl.ScreenTools   1.0

Rectangle {
    color:          qgcPal.window
    anchors.fill:   parent

    readonly property real _margins: ScreenTools.defaultFontPixelHeight

    QGCPalette { id: qgcPal; colorGroupEnabled: true }

    QGCFlickable {
        anchors.margins:    _margins
        anchors.fill:       parent
        contentWidth:       column.width
        contentHeight:      column.height
        clip:               true

        Column {
            id:         column
            spacing: 8
            QGCLabel { text: qsTr("ABOUT THIS GUI"); font.bold: true; font.family: "Helvetica"; font.pointSize: 16 }
            QGCLabel { text: qsTr("Redesigned by: Hai Chau Thanh") }
            QGCLabel { text: qsTr("Company: Vietnam Automation & Mechatronics Laboratory") }
            QGCLabel { text: qsTr("Contact: (+84) 383191679") }
            QGCLabel { text: qsTr("Email: thanhhaipif96@gmail.com") }
            Row{
                QGCLabel { text: qsTr("Github: ") }
                QGCLabel {
                    linkColor:          qgcPal.text
                    text:               "<a href=\"https://github.com/thanhhaibk96\">https://github.com/thanhhaibk96</a>"
                    onLinkActivated:    Qt.openUrlExternally(link)
                }
            }

            QGCLabel { text: qsTr("Copyright (C) 2017 QGroundControl Development Team. All rights reserved.") }
        }
    }
}
