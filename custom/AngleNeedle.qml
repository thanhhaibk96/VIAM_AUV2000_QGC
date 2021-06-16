import QtQuick 2.0

Item {
    id: id_root
    property int value: 0
    property int startAngle: 0
    property int lengthAngle: 0

    Rectangle {
        anchors.centerIn: parent

        Image {
            id: arrow
            width: 100; height: 100
            anchors{
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            source: "/qmlimages/resources/Custom_rudder.png"
            fillMode:           Image.PreserveAspectFit
        }

        anchors {
            horizontalCenter: id_root.horizontalCenter
        }
        antialiasing: true
    }

    rotation: _getAngle(value)

    function _getAngle(_value){
        var _tmpangle = 0;
//        console.log("_tmpangle is ", _value);
        if(_value < 0){
            _tmpangle = 180 + Math.abs(_value);
        }
        else{
            _tmpangle = startAngle + (lengthAngle/2 - _value);
        }

        return Math.min(Math.max(_tmpangle, startAngle), 180 + lengthAngle/2);
    }

    Behavior on rotation {
        SmoothedAnimation { velocity: 50 }
    }
}
