/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtQuick.Window 2.2

Rectangle {
    id: root
    color: "#313131"

    property int stage
    property var message: [
        "Welcome back sensei!",
        "Welcome back to kde plasma!",
        "loading loading loading....",
        "sudo pacman -S <package name>",
        "do you like cats too?"
    ]
    property int index: Math.floor(Math.random() * 5)

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Rectangle {
            id: imageSource
            color:  "transparent"
            anchors.fill: parent
            clip: true;

            AnimatedImage {
                id: face
                source: "images/serika.gif"
                paused: false
                anchors.fill: parent
                smooth: true
                visible: true
            }
        }
        Rectangle {
            anchors{
                bottom: parent.bottom
            }
            color: "black"
            opacity: 0.5
            height: 50
            width: Screen.width
        }

        Row {
            opacity: 0.5
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                left: parent.left
                margins: units.gridUnit
            }

            Image {
                source: "images/kde.svgz"
                sourceSize.height: units.gridUnit
                sourceSize.width: units.gridUnit
            }
            Text {
                color: "#eff0f1"
                renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: message[index]
            }
        }
        Row {
            spacing: units.smallSpacing + 3
            anchors {
                bottom: parent.bottom
                right: parent.right
                rightMargin: 15
            }
            Image {
                source: "images/arsipbiru.png"
                height: 50
                width: 140
                opacity: 1
            }
            Image {
                source: "images/busywidget.svgz"
                y: 13
                sourceSize.height: 25
                sourceSize.width: 25
                opacity: 0.5
                RotationAnimator on rotation {
                    id: rotationAnimator
                    from: 0
                    to: 360
                    duration: 1000
                    loops: Animation.Infinite
                }
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
