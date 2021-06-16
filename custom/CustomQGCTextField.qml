import QtQuick                  2.3
import QtQuick.Controls         1.2
import QtQuick.Controls.Styles  1.4
import QtQuick.Layouts          1.2

import QGroundControl.Palette       1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Controls      1.0

TextField {
    id:                 root
    textColor:          "white"
    implicitHeight:     30
    activeFocusOnPress: true
    antialiasing:       true

    property bool   showUnits:  false
    property string unitsLabel: ""

    property real _helpLayoutWidth: 0

    Component.onCompleted: selectAllIfActiveFocus()
    onActiveFocusChanged: selectAllIfActiveFocus()

    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }

    onEditingFinished: {
        if (ScreenTools.isMobile) {
            // Toss focus on mobile after Done on virtual keyboard. Prevent strange interactions.
            focus = false
        }
    }

    function selectAllIfActiveFocus() {
        if (activeFocus) {
            selectAll()
        }
    }

    QGCLabel {
        id:             unitsLabelWidthGenerator
        text:           unitsLabel
        width:          contentWidth + parent.__contentHeight * 0.666
        visible:        false
        antialiasing:   true
    }

    style: TextFieldStyle {
        id:             tfs
        font.pointSize: ScreenTools.defaultFontPointSize
        font.family:    ScreenTools.normalFontFamily
        renderType:     ScreenTools.isWindows ? Text.QtRendering : tfs.renderType   // This works around font rendering problems on windows

        background: Item {
            id: backgroundItem

            Rectangle {
                anchors.fill:           parent
                anchors.bottomMargin:   -1
                color:                  "#801F1F1F"
                radius: 2
            }

            Rectangle {
                anchors.fill:           parent
                border.width:           enabled ? 1 : 0
                border.color:           root.activeFocus ? "#3686FA" : "white"
                color:                  "#801F1F1F"
            }

            RowLayout {
                id:                     unitsHelpLayout
                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.rightMargin:    control.__contentHeight * 0.333
                anchors.right:          parent.right
                spacing:                ScreenTools.defaultFontPixelWidth / 4

                Component.onCompleted:  control._helpLayoutWidth = unitsHelpLayout.width
                onWidthChanged:         control._helpLayoutWidth = unitsHelpLayout.width

                Text {
                    Layout.alignment:   Qt.AlignVCenter
                    text:               control.unitsLabel
                    font.pointSize:     ScreenTools.defaultFontPointSize
                    font.family:        ScreenTools.normalFontFamily
                    antialiasing:       true
                    color:              control.textColor
                    visible:            control.showUnits
                }
            }

            MouseArea {
                anchors.margins:    ScreenTools.isMobile ? -(ScreenTools.defaultFontPixelWidth * 0.66) : 0 // Larger touch area for mobile
                anchors.fill:       unitsHelpLayout
                enabled:            control.activeFocus
                onClicked:          root.helpClicked()
            }
        }

        padding.right: control._helpLayoutWidth //control.showUnits ? unitsLabelWidthGenerator.width : control.__contentHeight * 0.333
    }
}
