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
import QtQuick.Layouts  1.2
import QtQuick.Controls.Styles 1.4

import QGroundControl                       1.0
import QGroundControl.FactSystem            1.0
import QGroundControl.FactControls          1.0
import QGroundControl.Controls              1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Palette               1.0

//-------------------------------------------------------------------------
//-- Parameters Controller
Item {
    id: _root
    property var    qgcView
    anchors.top:    parent.top
    anchors.bottom: parent.bottom
    width:          auvControlRow.width

    //Define Type of Controller for AUV
    property double _heading_PID_Controller: 1
    property double _heading_SM_Controller: 2
    property double _pitch_PID_Controller: 3
    property double _pitch_SM_Controller: 4
    property double _depth_PID_Controller: 5
    property double _depth_SM_Controller: 6
    property double _los_PID_Controller: 7
    property double _los_SM_Controller: 8
    property double _speed_PID_Controller: 9
    property double _speed_SM_Controller: 10
    property double _roll_PID_Controller: 11
    property double _roll_SM_Controller: 12

    property double _manual_control: 99

    property string _enable_or_disable_PIDController: "Enable"
    property string _enable_or_disable_SMController: "Enable"

    property var _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle

    property real _margins: ScreenTools.defaultFontPixelHeight
    property var _qgcPal:            QGCPalette { colorGroupEnabled: enabled }
    property int _changeController: 1
    property int _numOfController: 2
    property Component _comController: null
    property int _auvHeightComponent: 0
    property double _initialcenterX: 0
    property bool _checkInitial: true
    property var _flightModeCharacters: ["HEADING_PID", "HEADING_SM", "PITCH_PID", "PITCH_SM", "DEPTH_PID", "DEPTH_SM", "LOS_PID", "LOS_SM", "SPEED_PID","SPEED_SM", "ROLL_PID","ROLL_SM"]
    property string _strFlightModeCharacters: "AUV Controller"
    property double _indexController: 0
    property string _whichTypePIDController: null
    property string _whichTypeSMController: null
    property bool   _losController: false

    function _updateTypeController(){
        switch(_activeVehicle.flightMode){
            case "Heading Hold":
                _indexController = 0
                _auvHeightComponent = 280
                _losController = false
                lbComponent.color = "white"
                _whichTypePIDController = _flightModeCharacters[0]
                _whichTypeSMController = _flightModeCharacters[1]
                break;
            case "Depth Hold":
                _indexController = 4
                _auvHeightComponent = 280
                _losController = false
                lbComponent.color = "white"
                _whichTypePIDController = _flightModeCharacters[4]
                _whichTypeSMController = _flightModeCharacters[5]
                break;
            case "Pitch Hold":
                _indexController = 2
                _auvHeightComponent = 280
                _losController = false
                lbComponent.color = "white"
                _whichTypePIDController = _flightModeCharacters[2]
                _whichTypeSMController = _flightModeCharacters[3]
                break;
            case "Line Of Sight":
                _indexController = 6
                _losController = true
                _auvHeightComponent = 385
                lbComponent.color = "white"
                _whichTypePIDController = _flightModeCharacters[6]
                _whichTypeSMController = _flightModeCharacters[7]
                break;
            case "Speed Hold":
                _indexController = 8
                _losController = false
                _auvHeightComponent = 280
                lbComponent.color = "white"
                _whichTypePIDController = _flightModeCharacters[8]
                _whichTypeSMController = _flightModeCharacters[9]
                break;
            case "Roll Stabilize":
                _indexController = 10
                _losController = false
                _auvHeightComponent = 280
                lbComponent.color = "white"
                _whichTypePIDController = _flightModeCharacters[10]
                _whichTypeSMController = _flightModeCharacters[11]
                break;
            default:
                _indexController = 0
                _strFlightModeCharacters = "AUV Controller"
                 lbComponent.color = "red"
                _auvHeightComponent = 0
                _losController = true
                _whichTypePIDController = null
                _whichTypeSMController = null
                mainWindow.closePopUp()
                _comController = null                
                break
        }
    }

    Connections {
        target: _activeVehicle

        onFlightModeChanged:{
            _updateTypeController()
        }
    }

    function _whichController(_value){
        switch(_value){
        case 1:
            if(_whichTypePIDController||_whichTypeSMController){
                _comController = auvPIDParameters
            }
            break;
        case 2:
            if(_whichTypePIDController||_whichTypeSMController){
                _comController = auvSMParameters
            }
            break;
        }
        return _comController
    }

    FactPanelController {
        id:         controller
        factPanel:  _root.qgcView.viewPanel
    }

    Component {
        id: auvSMParameters

        Rectangle {           
            width:  auvSMControlCol.width   + ScreenTools.defaultFontPixelWidth  * 3
            height: _auvHeightComponent
            radius: ScreenTools.defaultFontPixelHeight * 0.2
            color:  "#801F1F1F"
            border.color:   _qgcPal.text

            Column {
                id:                 auvSMControlCol
                spacing:            ScreenTools.defaultFontPixelHeight * 0.5
                anchors.top: parent.top
                anchors.topMargin: ScreenTools.defaultFontPixelHeight
                anchors.horizontalCenter: parent.horizontalCenter

                Row{
                    spacing: 20

                    Button{
                        text: "\u25C0"

                        style: ButtonStyle {
                            label: Text {
                                renderType: Text.NativeRendering
                                y: parent.parent.height/100
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Helvetica"
                                font.pointSize: 15
                                color: "white"
                                text: control.text
                            }

                         background: Rectangle {
                             implicitWidth:  ScreenTools.implicitButtonHeight
                             implicitHeight: ScreenTools.implicitButtonHeight
                             border.width: 2
                             border.color: "white"
                             radius: ScreenTools.implicitButtonHeight
                             color: control.pressed ? "#80273054" : "transparent"
                            }
                        }

                        onClicked: {
                            _changeController++
                            if(_changeController > _numOfController) _changeController = 1
                            else if(_changeController < 1) _changeController = _numOfController
                            mainWindow.showPopUp(_whichController(_changeController), mapToItem(toolBar, x, y).x + (width / 2))
                        }
                    }

                    Text {
                        y: parent.height/5
                        width: 135
                        text:           _whichTypeSMController
                        font.family:    ScreenTools.demiboldFontFamily
                        font.pointSize:         ScreenTools.mediumFontPointSize
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color:          _qgcPal.text
                        antialiasing:   true
                    }

                    Button{
                        text: "\u25B6"

                        style: ButtonStyle {
                            label: Text {
                                renderType: Text.NativeRendering
                                y: parent.parent.height/100
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Helvetica"
                                font.pointSize: 15
                                color: "white"
                                text: control.text
                            }

                         background: Rectangle {
                             implicitWidth:  ScreenTools.implicitButtonHeight
                             implicitHeight: ScreenTools.implicitButtonHeight
                             border.width: 2
                             border.color: "white"
                             radius: ScreenTools.implicitButtonHeight
                             color: control.pressed ? "#80273054" : "transparent"
                            }
                        }
                        onClicked: {
                            _changeController++
                            if(_changeController > _numOfController) _changeController = 1
                            else if(_changeController < 1) _changeController = _numOfController
                            mainWindow.showPopUp(_whichController(_changeController), mapToItem(toolBar, x, y).x + (width / 2))
                            _updateTypeController()
                        }
                    }
                }

                Flow{
                    width:              parent.width
                    layoutDirection:    Qt.LeftToRight
                    spacing:            5

                    Repeater{
                        model: 1
                        Loader {
                            sourceComponent: _losController? cpLOS_SMParameters : cpDesiredValueSM
                        }
                    }
                }

                Component{
                    id: cpDesiredValueSM
                    Rectangle{
                        color: "transparent"
                        width: coverColDesiredValueSM.width
                        height: coverColDesiredValueSM.height
                        Column{
                            id: coverColDesiredValueSM
                            spacing: 5
                            Row{
                                spacing: _margins

                                Label {
                                    id: lbSMValueDesried
                                    text: "Desired Value"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbSMValueDesried.baseline
                                    fact:               controller.getParameterFact(-1, _whichTypeSMController + "_DES")
                                }
                            }

                            Rectangle{
                                color: "white"
                                height: 1
                                width: coverColDesiredValueSM.width
                            }
                        }
                    }
                }

                Component{
                    id: cpLOS_SMParameters
                    Rectangle{
                        color: "transparent"
                        width: coverColLOS_SMParameters.width
                        height: coverColLOS_SMParameters.height
                        Column{
                            id: coverColLOS_SMParameters
                            spacing: 5
                            Row{
                                spacing: _margins

                                Label {
                                    id: lbLOS_SM_Radius
                                    text: "R"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbLOS_SM_Radius.baseline
                                    fact:               controller.getParameterFact(-1, "LOS_RADIUS")
                                }
                            }

                            Row{
                                spacing: _margins

                                Label {
                                    id: lbLOS_SM_DeltaMin
                                    text: "\u0394" + "min"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbLOS_SM_DeltaMin.baseline
                                    fact:               controller.getParameterFact(-1, "LOS_DELTA_MIN")
                                }
                            }

                            Row{
                                spacing: _margins

                                Label {
                                    id: lbLOS_SM_DeltaMax
                                    text: "\u0394" + "max"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbLOS_SM_DeltaMax.baseline
                                    fact:               controller.getParameterFact(-1, "LOS_DELTA_MAX")
                                }
                            }

                            Row{
                                spacing: _margins

                                Label {
                                    id: lbLOS_SM_Beta
                                    text: "\u03b2"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbLOS_SM_Beta.baseline
                                    fact:               controller.getParameterFact(-1, "LOS_BETA")
                                }
                            }
                            Rectangle{
                                color: "white"
                                height: 1
                                width: coverColLOS_SMParameters.width
                            }
                        }
                    }
                }

                Row{
                    spacing: _margins

                    Label {
                        id: lbSMValue_k
                        text: "\u03B5"
                        width: 100
                        color: "white"
                        font.pointSize: 11
                        y: parent.height/8
                    }

                    CustomFactTextField {
                        width:              120
                        anchors.baseline:   lbSMValue_k.baseline
                        fact:               controller.getParameterFact(-1, _whichTypeSMController + "_E")
                    }
                }

                Row{
                    spacing: _margins

                    Label {
                        id: lbSMValue_K
                        text: "K"
                        width: 100
                        color: "white"
                        y: parent.height/8
                    }

                    CustomFactTextField {
                        width:              120
                        anchors.baseline:   lbSMValue_K.baseline
                        fact:               controller.getParameterFact(-1, _whichTypeSMController + "_K")
                    }
                }

                Button{
                    text: _enable_or_disable_SMController
                    anchors.horizontalCenter: parent.horizontalCenter

                    style: ButtonStyle {
                        label: Text {
                            renderType: Text.NativeRendering
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Helvetica"
                            font.pointSize: 12
                            color: "white"
                            text: control.text
                        }

                     background: Rectangle {
                         implicitWidth:  120
                         implicitHeight: 30
                         border.width: 1.5
                         border.color: "white"
                         radius: 10
                         color: control.pressed ? "#80273054" : "transparent"
                        }
                    }
                    onClicked: {
                        if(_enable_or_disable_SMController == "Enable"){
                            _enable_or_disable_SMController = "Disable"
                            _activeVehicle.setAUVController(_indexController + _changeController, 1)
                        }
                        else{
                            _enable_or_disable_SMController = "Enable"
                            _activeVehicle.setAUVController(_indexController + _changeController, 0)
                        }
                    }
                }
            }

//            MouseArea {
//                // This MouseArea prevents the Map below it from getting Mouse events. Without this
//                // things like mousewheel will scroll the Flickable and then scroll the map as well.
//                anchors.fill:       parent
//                preventStealing:    true
//                onWheel:            wheel.accepted = true
//            }

            Component.onCompleted: {
                var pos;
                if(_checkInitial){
                    pos = mapFromItem(toolBar, centerX - (width / 2), toolBar.height)
                    x = pos.x
                    y = pos.y + ScreenTools.defaultFontPixelHeight
                    _initialcenterX = centerX
                    _checkInitial = false
                }
                else{
                    pos = mapFromItem(toolBar, _initialcenterX - (width / 2), toolBar.height)
                    x = pos.x
                    y = pos.y + ScreenTools.defaultFontPixelHeight
                }
                _updateTypeController()
            }
        }
    }

    Component {
        id: auvPIDParameters

        Rectangle {
            width:  auvPIDControlCol.width   + ScreenTools.defaultFontPixelWidth  * 3
            height: _auvHeightComponent
            radius: ScreenTools.defaultFontPixelHeight * 0.2
            color:  "#801F1F1F"
            border.color:   _qgcPal.text

            Column {
                id:                 auvPIDControlCol
                spacing:            ScreenTools.defaultFontPixelHeight * 0.5
                anchors.top: parent.top
                anchors.topMargin: ScreenTools.defaultFontPixelHeight
                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.margins:    ScreenTools.defaultFontPixelHeight
//                anchors.centerIn:   parent

                Row{
                    spacing: 20

                    Button{
                        text: "\u25C0"

                        style: ButtonStyle {
                            label: Text {
                                renderType: Text.NativeRendering
                                y: parent.parent.height/100
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Helvetica"
                                font.pointSize: 15
                                color: "white"
                                text: control.text
                            }

                         background: Rectangle {
                             implicitWidth:  ScreenTools.implicitButtonHeight
                             implicitHeight: ScreenTools.implicitButtonHeight
                             border.width: 2
                             border.color: "white"
                             radius: ScreenTools.implicitButtonHeight
                             color: control.pressed ? "#80273054" : "transparent"
                            }
                        }

                        onClicked: {
                            _changeController++
                            if(_changeController > _numOfController) _changeController = 1
                            else if(_changeController < 1) _changeController = _numOfController
                            mainWindow.showPopUp(_whichController(_changeController), mapToItem(toolBar, x, y).x + (width / 2))
                            _updateTypeController()
                        }
                    }

                    Text {
                        y: parent.height/5
                        width: 135
                        text:           _whichTypePIDController
                        font.family:    ScreenTools.demiboldFontFamily
                        font.pointSize:         ScreenTools.mediumFontPointSize
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color:          _qgcPal.text
                        antialiasing:   true
                    }

                    Button{
                        text: "\u25B6"

                        style: ButtonStyle {
                            label: Text {
                                renderType: Text.NativeRendering
                                y: parent.parent.height/100
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Helvetica"
                                font.pointSize: 15
                                color: "white"
                                text: control.text
                            }

                         background: Rectangle {
                             implicitWidth:  ScreenTools.implicitButtonHeight
                             implicitHeight: ScreenTools.implicitButtonHeight
                             border.width: 2
                             border.color: "white"
                             radius: ScreenTools.implicitButtonHeight
                             color: control.pressed ? "#80273054" : "transparent"
                            }
                        }
                        onClicked: {
                            _changeController++
                            if(_changeController > _numOfController) _changeController = 1
                            else if(_changeController < 1) _changeController = _numOfController
                            mainWindow.showPopUp(_whichController(_changeController), mapToItem(toolBar, x, y).x + (width / 2))
                            _updateTypeController()
                        }
                    }
                }

                Flow{
                    width:              parent.width
                    layoutDirection:    Qt.LeftToRight
                    spacing:            5

                    Repeater{
                        model: 1
                        Loader {
                            sourceComponent: _losController? cpLOS_PIDParameters : cpDesiredValuePID
                        }
                    }
                }

                Component{
                    id: cpDesiredValuePID
                    Rectangle{
                        color: "transparent"
                        width: coverColDesiredValuePID.width
                        height: coverColDesiredValuePID.height
                        Column{
                            id: coverColDesiredValuePID
                            spacing: 5
                            Row{
                                spacing: _margins

                                Label {
                                    id: lbPIDValueDesried
                                    text: "Desired Value"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbPIDValueDesried.baseline
                                    fact:               controller.getParameterFact(-1, _whichTypePIDController + "_DES")
                                }
                            }

                            Rectangle{
                                color: "white"
                                height: 1
                                width: coverColDesiredValuePID.width
                            }
                        }
                    }
                }

                Component{
                    id: cpLOS_PIDParameters
                    Rectangle{
                        color: "transparent"
                        width: coverColLOS_PIDParameters.width
                        height: coverColLOS_PIDParameters.height
                        Column{
                            id: coverColLOS_PIDParameters
                            spacing: 5
                            Row{
                                spacing: _margins

                                Label {
                                    id: lbLOS_PID_Radius
                                    text: "R"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbLOS_PID_Radius.baseline
                                    fact:               controller.getParameterFact(-1, "LOS_RADIUS")
                                }
                            }

                            Row{
                                spacing: _margins

                                Label {
                                    id: lbLOS_PID_DeltaMin
                                    text: "\u0394" + "min"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbLOS_PID_DeltaMin.baseline
                                    fact:               controller.getParameterFact(-1, "LOS_DELTA_MIN")
                                }
                            }

                            Row{
                                spacing: _margins

                                Label {
                                    id: lbLOS_PID_DeltaMax
                                    text: "\u0394" + "max"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbLOS_PID_DeltaMax.baseline
                                    fact:               controller.getParameterFact(-1, "LOS_DELTA_MAX")
                                }
                            }

                            Row{
                                spacing: _margins

                                Label {
                                    id: lbLOS_PID_Beta
                                    text: "\u03b2"
                                    width: 100
                                    color: "white"
                                    y: parent.height/8
                                }

                                CustomFactTextField {
                                    width:              120
                                    anchors.baseline:   lbLOS_PID_Beta.baseline
                                    fact:               controller.getParameterFact(-1, "LOS_BETA")
                                }
                            }
                            Rectangle{
                                color: "white"
                                height: 1
                                width: coverColLOS_PIDParameters.width
                            }
                        }
                    }
                }

                Row{
                    spacing: _margins

                    Label {
                        id: lbPIDValue_Kp
                        text: "Kp"
                        width: 100
                        color: "white"
                        y: parent.height/8
                    }

                    CustomFactTextField {
                        width:              120
                        anchors.baseline:   lbPIDValue_Kp.baseline
                        fact:               controller.getParameterFact(-1, _whichTypePIDController+ "_KP")
                    }
                }

                Row{
                    spacing: _margins

                    Label {
                        id: lbPIDValue_Ki
                        text: "Ki"
                        width: 100
                        color: "white"
                        y: parent.height/8
                    }

                    CustomFactTextField {
                        width:              120
                        anchors.baseline:   lbPIDValue_Ki.baseline
                        fact:               controller.getParameterFact(-1, _whichTypePIDController+ "_KI")
                    }
                }

                Row{
                    spacing: _margins

                    Label {
                        id: lbPIDValue_Kd
                        text: "Kd"
                        width: 100
                        color: "white"
                        y: parent.height/8
                    }

                    CustomFactTextField {
                        width:              120
                        anchors.baseline:   lbPIDValue_Kd.baseline
                        fact:               controller.getParameterFact(-1, _whichTypePIDController+ "_KD")
                    }
                }

                Button{
                    text: _enable_or_disable_PIDController
                    anchors.horizontalCenter: parent.horizontalCenter

                    style: ButtonStyle {
                        label: Text {
                            renderType: Text.NativeRendering
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Helvetica"
                            font.pointSize: 12
                            color: "white"
                            text: control.text
                        }

                     background: Rectangle {
                         implicitWidth:  120
                         implicitHeight: 30
                         border.width: 1.5
                         border.color: "white"
                         radius: 10
                         color: control.pressed ? "#80273054" : "transparent"
                        }
                    }
                    onClicked: {
                        console.log("index" + _indexController)
                        console.log("change " + _changeController)
                        if(_enable_or_disable_PIDController == "Enable"){
                            _enable_or_disable_PIDController = "Disable"
                            _activeVehicle.setAUVController(_indexController + _changeController, 1)

                           //                         _activeVehicle.setAUVController(_indexController , 1)
                        }
                        else{
                            _enable_or_disable_PIDController = "Enable"
                            _activeVehicle.setAUVController(_indexController + _changeController, 0)

                           // _activeVehicle.setAUVController(_indexController , 0)
                        }

                    }
                }
            }

//            MouseArea {
//                // This MouseArea prevents the Map below it from getting Mouse events. Without this
//                // things like mousewheel will scroll the Flickable and then scroll the map as well.
//                anchors.fill:       parent
//                preventStealing:    true
//                onWheel:            wheel.accepted = true
//            }

            Component.onCompleted: {
                var pos;
                if(_checkInitial){                    
                    pos = mapFromItem(toolBar, centerX - (width / 2), toolBar.height)
                    x = pos.x
                    y = pos.y + ScreenTools.defaultFontPixelHeight
                    _initialcenterX = centerX
                    _checkInitial = false
                }
                else{
                    pos = mapFromItem(toolBar, _initialcenterX - (width / 2), toolBar.height)
                    x = pos.x
                    y = pos.y + ScreenTools.defaultFontPixelHeight
                }
                _updateTypeController()
            }
        }
    }

    Row {
        id:             auvControlRow
        anchors.top:    parent.top
        anchors.bottom: parent.bottom
        opacity:        1

        QGCColoredImage {
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            source:             "qrc:/qmlimages/src/AutoPilotPlugins/PX4/Images/auv_control.png"
            fillMode:           Image.PreserveAspectFit
            color:              qgcPal.text
        }
        Text {
            id:                     lbComponent
            text:                   " " + _strFlightModeCharacters
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: ScreenTools.mediumFontPointSize
            font.family:    ScreenTools.normalFontFamily
            color:          _qgcPal.Text
            antialiasing:   true

            Component.onCompleted: {
                _updateTypeController()
            }
        }
    }
    MouseArea {
        anchors.fill:   parent
        onClicked:      mainWindow.showPopUp(_whichController(_changeController), mapToItem(toolBar, x, y).x + (width / 2))
    }    
}
