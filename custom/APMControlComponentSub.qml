/****************************************************************************
 *
 *   (c) 2009-2018 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


import QtQuick              2.3
import QtQuick.Controls     1.2

import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.Palette       1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0

SetupPage {
    id:             controlPage
    pageComponent:  controlPageComponent

    Component {
        id: controlPageComponent

        Column {
            width:      availableWidth
            spacing:    _margins

            FactPanelController { id: controller; factPanel: controlPage.viewPanel }

            QGCPalette { id: palette; colorGroupEnabled: true }

            property real _margins: ScreenTools.defaultFontPixelHeight

            ExclusiveGroup { id: buttonGroup }

            Row {
                spacing: _margins

                QGCButton {
                    id:             headingButton
                    text:           qsTr("AUV Heading Controller")
                    exclusiveGroup: buttonGroup
                    checked:        true
                    onClicked:      checked = true
                }
                QGCButton {
                    id:             pitchButton
                    text:           qsTr("AUV Pitch Controller")
                    exclusiveGroup: buttonGroup
                    onClicked:      checked = true
                }

                QGCButton {
                    id:             depthButton
                    text:           qsTr("AUV Depth Controller")
                    exclusiveGroup: buttonGroup
                    onClicked:      checked = true
                }
                QGCButton {
                    id:             thrusterButton
                    text:           qsTr("Thruster PID Controller")
                    exclusiveGroup: buttonGroup
                    onClicked:      checked = true
                }
            }

            Rectangle {
                id:                 headingPIDParams
                visible:            headingButton.checked
                anchors.left:       parent.left
                anchors.right:      parent.right
                height:             headingPIDColumn.height + _margins*2
                color:              palette.windowShade

                Column {

                    id:                 headingPIDColumn
                    anchors.top: headingPIDParams.top
                    anchors.left: headingPIDParams.left
                    anchors.margins: _margins
                    property var _labelWidth: ScreenTools.defaultFontPixelWidth * 15
                    property var _editWidth: ScreenTools.defaultFontPixelWidth * 20
                    spacing: ScreenTools.defaultFontPixelHeight
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "DOITRONG") }
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "XYLANH") }

                    QGCLabel {
                        text: "PID Contrller"
                        width:              headingPIDColumn._labelWidth
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "Desired Heading:"
                            id: desiredHeadingPIDLabel
                            width:              headingPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              headingPIDColumn._editWidth
                            anchors.baseline:   desiredHeadingPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "                     KP:"
                            id: kpHeadingPIDLabel
                            width:              headingPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              headingPIDColumn._editWidth
                            anchors.baseline:   kpHeadingPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KI:"
                            id: kiHeadingPIDLabel
                            width:              headingPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              headingPIDColumn._editWidth
                            anchors.baseline:   kiHeadingPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KD:"
                            id: kdHeadingPIDLabel
                            width:              headingPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              headingPIDColumn._editWidth
                            anchors.baseline:   kdHeadingPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                } // Column - WPNAV parameters
            } // Rectangle - WPNAV parameters
            Rectangle {
                id:                 headingSMParams
                visible:            headingButton.checked
                anchors.left:       parent.left
                anchors.right:      parent.right
                height:             headingSMColumn.height + _margins*2
                color:              palette.windowShade

                Column {

                    id:                 headingSMColumn
                    anchors.top: headingSMParams.top
                    anchors.left: headingSMParams.left
                    anchors.margins: _margins
                    property var _labelWidth: ScreenTools.defaultFontPixelWidth * 15
                    property var _editWidth: ScreenTools.defaultFontPixelWidth * 20
                    spacing: ScreenTools.defaultFontPixelHeight
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "DOITRONG") }
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "XYLANH") }

                    QGCLabel {
                        text: "Sliding Mode Controller"
                        width:              headingSMColumn._labelWidth
                    }

                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "Desired Heading:"
                            id: desiredHeadingSMLabel
                            width:              headingSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              headingSMColumn._editWidth
                            anchors.baseline:   desiredHeadingSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "                     KP:"
                            id: kpHeadingSMLabel
                            width:              headingSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              headingSMColumn._editWidth
                            anchors.baseline:   kpHeadingSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KI:"
                            id: kiHeadingSMLabel
                            width:              headingSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              headingSMColumn._editWidth
                            anchors.baseline:   kiHeadingSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KD:"
                            id: kdHeadingSMLabel
                            width:              headingSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              headingSMColumn._editWidth
                            anchors.baseline:   kdHeadingSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                } // Column - WPNAV parameters
            } // Rectangle - WPNAV parameters

            Rectangle {
                id:                 pitchPIDParams
                visible:            pitchButton.checked
                anchors.left:       parent.left
                anchors.right:      parent.right
                height:             pitchPIDColumn.height + _margins*2
                color:              palette.windowShade

                Column {

                    id:                 pitchPIDColumn
                    anchors.top: pitchPIDParams.top
                    anchors.left: pitchPIDParams.left
                    anchors.margins: _margins
                    property var _labelWidth: ScreenTools.defaultFontPixelWidth * 15
                    property var _editWidth: ScreenTools.defaultFontPixelWidth * 20
                    spacing: ScreenTools.defaultFontPixelHeight
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "DOITRONG") }
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "XYLANH") }

                    QGCLabel {
                        text: "PID Contrller"
                        width:              pitchPIDColumn._labelWidth
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "Desired Pitch:"
                            id: desiredpitchPIDLabel
                            width:              pitchPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              pitchPIDColumn._editWidth
                            anchors.baseline:   desiredpitchPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "                     KP:"
                            id: kppitchPIDLabel
                            width:              pitchPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              pitchPIDColumn._editWidth
                            anchors.baseline:   kppitchPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KI:"
                            id: kipitchPIDLabel
                            width:              pitchPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              pitchPIDColumn._editWidth
                            anchors.baseline:   kipitchPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KD:"
                            id: kdpitchPIDLabel
                            width:              pitchPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              pitchPIDColumn._editWidth
                            anchors.baseline:   kdpitchPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                } // Column - WPNAV parameters
            } // Rectangle - WPNAV parameters
            Rectangle {
                id:                 pitchSMParams
                visible:            pitchButton.checked
                anchors.left:       parent.left
                anchors.right:      parent.right
                height:             pitchSMColumn.height + _margins*2
                color:              palette.windowShade

                Column {

                    id:                 pitchSMColumn
                    anchors.top: pitchSMParams.top
                    anchors.left: pitchSMParams.left
                    anchors.margins: _margins
                    property var _labelWidth: ScreenTools.defaultFontPixelWidth * 15
                    property var _editWidth: ScreenTools.defaultFontPixelWidth * 20
                    spacing: ScreenTools.defaultFontPixelHeight
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "DOITRONG") }
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "XYLANH") }

                    QGCLabel {
                        text: "Sliding Mode Controller"
                        width:              pitchSMColumn._labelWidth
                    }

                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "Desired Pitch:"
                            id: desiredpitchSMLabel
                            width:              pitchSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              pitchSMColumn._editWidth
                            anchors.baseline:   desiredpitchSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "                     KP:"
                            id: kppitchSMLabel
                            width:              pitchSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              pitchSMColumn._editWidth
                            anchors.baseline:   kppitchSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KI:"
                            id: kipitchSMLabel
                            width:              pitchSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              pitchSMColumn._editWidth
                            anchors.baseline:   kipitchSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KD:"
                            id: kdpitchSMLabel
                            width:              pitchSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              pitchSMColumn._editWidth
                            anchors.baseline:   kdpitchSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                } // Column - WPNAV parameters
            } // Rectangle - WPNAV parameters

            Rectangle {
                id:                 depthPIDParams
                visible:            depthButton.checked
                anchors.left:       parent.left
                anchors.right:      parent.right
                height:             depthPIDColumn.height + _margins*2
                color:              palette.windowShade

                Column {

                    id:                 depthPIDColumn
                    anchors.top: depthPIDParams.top
                    anchors.left: depthPIDParams.left
                    anchors.margins: _margins
                    property var _labelWidth: ScreenTools.defaultFontPixelWidth * 15
                    property var _editWidth: ScreenTools.defaultFontPixelWidth * 20
                    spacing: ScreenTools.defaultFontPixelHeight
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "DOITRONG") }
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "XYLANH") }

                    QGCLabel {
                        text: "PID Contrller"
                        width:              depthPIDColumn._labelWidth
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "Desired Depth:"
                            id: desireddepthPIDLabel
                            width:              depthPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              depthPIDColumn._editWidth
                            anchors.baseline:   desireddepthPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "                     KP:"
                            id: kpdepthPIDLabel
                            width:              depthPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              depthPIDColumn._editWidth
                            anchors.baseline:   kpdepthPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KI:"
                            id: kidepthPIDLabel
                            width:              depthPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              depthPIDColumn._editWidth
                            anchors.baseline:   kidepthPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KD:"
                            id: kddepthPIDLabel
                            width:              depthPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              depthPIDColumn._editWidth
                            anchors.baseline:   kddepthPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                } // Column - WPNAV parameters
            } // Rectangle - WPNAV parameters
            Rectangle {
                id:                 depthSMParams
                visible:            depthButton.checked
                anchors.left:       parent.left
                anchors.right:      parent.right
                height:             depthSMColumn.height + _margins*2
                color:              palette.windowShade

                Column {

                    id:                 depthSMColumn
                    anchors.top: depthSMParams.top
                    anchors.left: depthSMParams.left
                    anchors.margins: _margins
                    property var _labelWidth: ScreenTools.defaultFontPixelWidth * 15
                    property var _editWidth: ScreenTools.defaultFontPixelWidth * 20
                    spacing: ScreenTools.defaultFontPixelHeight
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "DOITRONG") }
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "XYLANH") }

                    QGCLabel {
                        text: "Sliding Mode Controller"
                        width:              depthSMColumn._labelWidth
                    }

                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "Desired Depth:"
                            id: desireddepthSMLabel
                            width:              depthSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              depthSMColumn._editWidth
                            anchors.baseline:   desireddepthSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "                     KP:"
                            id: kpdepthSMLabel
                            width:              depthSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              depthSMColumn._editWidth
                            anchors.baseline:   kpdepthSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KI:"
                            id: kidepthSMLabel
                            width:              depthSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              depthSMColumn._editWidth
                            anchors.baseline:   kidepthSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KD:"
                            id: kddepthSMLabel
                            width:              depthSMColumn._labelWidth
                        }

                        FactTextField {
                            width:              depthSMColumn._editWidth
                            anchors.baseline:   kddepthSMLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                } // Column - WPNAV parameters
            } // Rectangle - WPNAV parameters
            Rectangle {
                id:                 thrusterPIDParams
                visible:            thrusterButton.checked
                anchors.left:       parent.left
                anchors.right:      parent.right
                height:             thrusterPIDColumn.height + _margins*2
                color:              palette.windowShade

                Column {

                    id:                 thrusterPIDColumn
                    anchors.top: thrusterPIDParams.top
                    anchors.left: thrusterPIDParams.left
                    anchors.margins: _margins
                    property var _labelWidth: ScreenTools.defaultFontPixelWidth * 15
                    property var _editWidth: ScreenTools.defaultFontPixelWidth * 20
                    spacing: ScreenTools.defaultFontPixelHeight
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "DOITRONG") }
//                    FactTextFieldSlider { fact: controller.getParameterFact(-1, "XYLANH") }

                    QGCLabel {
                        text: "PID Contrller"
                        width:              thrusterPIDColumn._labelWidth
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "Desired Thruster:"
                            id: desiredthrusterPIDLabel
                            width:              thrusterPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              thrusterPIDColumn._editWidth
                            anchors.baseline:   desiredthrusterPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                    Row {
                        spacing: _margins / 2
                        QGCLabel {
                            text: "                     KP:"
                            id: kpthrusterPIDLabel
                            width:              thrusterPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              thrusterPIDColumn._editWidth
                            anchors.baseline:   kpthrusterPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KI:"
                            id: kithrusterPIDLabel
                            width:              thrusterPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              thrusterPIDColumn._editWidth
                            anchors.baseline:   kithrusterPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }

                        QGCLabel {
                            text: "                     KD:"
                            id: kdthrusterPIDLabel
                            width:              thrusterPIDColumn._labelWidth
                        }

                        FactTextField {
                            width:              thrusterPIDColumn._editWidth
                            anchors.baseline:   kdthrusterPIDLabel.baseline
                            fact:               controller.getParameterFact(-1, "FS_PRESS_MAX")
                        }
                    }
                } // Column - WPNAV parameters
            } // Rectangle - WPNAV parameters
        } // Column
    } // Component
} // SetupView
