import QtQuick 2.0
import QtQuick.Window 2.12
import QtMultimedia 5.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

import QGroundControl                       1.0
import QGroundControl.Controls              1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Palette               1.0
import QGroundControl.Controllers           1.0
import QGroundControl.FactSystem            1.0
import QGroundControl.FactControls          1.0

// Modify QGC_GST_STREAMING L.125 in VideoStreaming.pri to enable streaming video

Item {
    id: root
    anchors.fill:               parent
    z:      0

    property var _activeWebServer: QGroundControl.settingsManager.videoSettings

    property bool   _showCameraFullScreen: false
    property string _httpvideowebserver: " "
    property bool   _iconStart_Stop: true
    property int   _deviceWindow: 5
    property int   _anchorLeft: 5
    property int   _anchorBottom: 5

    function changeIconStart_Stop(_toggle){
        return !_toggle;
    }

    Rectangle{
        id: rootSmallWindow
        anchors.left: parent.left
        anchors.leftMargin: ScreenTools.defaultFontPixelWidth * 2.5
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:    ScreenTools.defaultFontPixelWidth * 2.3
        width: 262; height: 156
        color:          Qt.rgba(0,0,0,0)
    }

    function showCameraFullScreen(_enable){
        if(_enable == false)
        {
            backgroundVideo.anchors.fill = root
        }
        else
        {
            backgroundVideo.anchors.fill = rootSmallWindow
        }
        return !_enable;
    }

    Rectangle{
        id: backgroundVideo
        anchors.fill: rootSmallWindow
        color:          Qt.rgba(0,0,0,0.75)

        Video {
            id: video
            width : parent.width
            height : parent.height

            source: _httpvideowebserver

            anchors.centerIn: parent
            focus: true
//            autoLoad: true
//            autoPlay: true

            Rectangle{
                id: buttonStart_Stop
                anchors.left: parent.left
                anchors.leftMargin: _anchorLeft
                anchors.bottom: parent.bottom
                anchors.bottomMargin: _anchorBottom

                width: backgroundVideo.width/_deviceWindow; height: backgroundVideo.height/_deviceWindow
                border.color: "white"
                radius: 5

                color: "transparent"

                Image {
                    id: imgStart_Stop
                    width: parent.width/2 + 10; height: parent.height/2 + 10
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    source: _iconStart_Stop? "/qmlimages/resources/play_video_icon.svg" : "/qmlimages/resources/pause_video_icon.svg"
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons:    Qt.LeftButton
                    onClicked: {
                        if(_iconStart_Stop == true)
                        {
                            video.play()
                        }
                        else
                        {
                            video.pause()
                        }
                        _iconStart_Stop = root.changeIconStart_Stop(_iconStart_Stop)
                    }
                }
            }

            MouseArea {
                id: mouseArea
                anchors.centerIn: parent
                width: parent.width/2 + 20
                height: parent.height/2 + 20
                onDoubleClicked:{
                    if(_showCameraFullScreen == true)
                    {
                        _anchorLeft = 5
                        _anchorBottom = 5
                        _deviceWindow = 5
                    }
                    else
                    {
                        _anchorLeft = ScreenTools.defaultFontPixelWidth * 2.5
                        _anchorBottom = ScreenTools.defaultFontPixelWidth * 2.3
                        _deviceWindow = 10
                    }
                    _showCameraFullScreen = showCameraFullScreen(_showCameraFullScreen)
                }
           }
        }

        Connections {
            target: _activeWebServer

            onWebServerVideoHttpChanged:  _httpvideowebserver = _httpWebServer
        }
    }
}
