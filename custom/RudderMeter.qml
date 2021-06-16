import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs  1.2
import QtQuick.Layouts  1.2

Item {
    id: id_root
    property int value: 0

    Rectangle {
        id: id_rudder

        property int numberIndexs: 25
        property int startAngle: 120
        property int angleLength: 5
        property int maxAngle: 120

        anchors.centerIn: parent
        height: Math.min(id_root.width, id_root.height)
        width: height
        radius: width/2
        color: "transparent"
        border.color: "white"
        border.width: id_rudder.height * 0.02

        Repeater {
            model: id_rudder.numberIndexs

            Item {
                height: id_rudder.height/2
                transformOrigin: Item.Bottom
                rotation: index * id_rudder.angleLength + id_rudder.startAngle
                x: id_rudder.width/2

                Rectangle {
                    height: index % 4 ? id_rudder.height * 0.03 : id_rudder.height * 0.07
                    width: index % 4 ? height / 4 : height / 8
                    color: "white"
                    antialiasing: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: id_rudder.height * 0.03
                }
            }
        }

        Repeater {
            model: id_rudder.numberIndexs / 4 + 1

            Item {
                height: id_rudder.height/2 - 1
                transformOrigin: Item.Bottom
                rotation: index * id_rudder.angleLength * 4 + id_rudder.startAngle
                x: id_rudder.width/2

                Text {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                    x: 0
                    y: id_rudder.height * 0.09
                    color: "white"
                    rotation: 180 + (180 -  id_rudder.startAngle - index * id_rudder.angleLength * 4)
                    text: 60 - index * id_rudder.angleLength * 4
                    font.pixelSize: id_rudder.height * 0.06
                }
            }
        }
    }

    Text {
        id: txtAngle
        text: id_root.value + "\ndegree"
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        font.bold: true
        anchors {
            horizontalCenter: parent.horizontalCenter
        }
        anchors.top: parent.top
        anchors.topMargin: 15
    }

    AngleNeedle {
        id: id_angleNeedle
        anchors {
            top: id_rudder.top
            bottom: id_rudder.bottom
            horizontalCenter: parent.horizontalCenter
        }
        value: id_root.value
        startAngle: id_rudder.startAngle
        lengthAngle: id_rudder.maxAngle
    }
}
