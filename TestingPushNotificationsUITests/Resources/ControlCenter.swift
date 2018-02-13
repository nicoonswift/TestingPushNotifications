//
//  ControlCenter.swift
//  TestingPushNotificationsUITests
//
//  Created by Nicolás García on 13-02-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import Foundation
import XCTest

struct ControlCenter {
    let springboard: XCUIApplication
    
    private var controlCenterLayoutView: XCUIElementQuery {
        return springboard/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"ControlCenterView\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.scrollViews["ControlCenterLayoutView"].otherElements
    }
    
    private var elementsQuery: XCUIElementQuery {
        return controlCenterLayoutView.scrollViews.otherElements
    }
    
    var cellularDataButtonSwitch: XCUIElement {
        return elementsQuery.switches["cellular-data-button"]
    }
    
    var wifiButton: XCUIElement {
        return elementsQuery.switches["wifi-button"]
    }
    
    var bluetoothButton: XCUIElement {
        return elementsQuery.switches["bluetooth-button"]
    }
    
    var airplaneModeButtonSwitch: XCUIElement {
        return elementsQuery.switches["airplane-mode-button"]
    }
    
    var flashlightButton: XCUIElement {
        return controlCenterLayoutView.buttons["flashlight"]
    }
    
    var doNotDisturbSwitch: XCUIElement {
        return controlCenterLayoutView.switches["do-not-disturb"]
    }
    
    var orientationLockSwitch: XCUIElement {
        return controlCenterLayoutView.switches["orientation-lock"]
    }
    
    var closeButton: XCUIElement {
        return     springboard.otherElements["ControlCenterView"].children(matching: .other).element(boundBy: 0)
    }
    
}
