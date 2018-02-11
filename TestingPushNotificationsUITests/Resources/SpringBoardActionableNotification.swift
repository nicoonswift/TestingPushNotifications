//
//  SpringBoardActionableNotification.swift
//  TestingPushNotificationsUITests
//
//  Created by Nicolás García on 11-02-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import Foundation
import XCTest

struct SpringBoardActionableNotification {
    
    let springboard: XCUIApplication
    
    var titleButton: XCUIElement {
        return springboard.buttons["TESTINGPUSHNOTIFICATIONS"].firstMatch
    }
    var messageButton: XCUIElement {
        return springboard.buttons["Your bike was stolen!"].firstMatch
    }
    var dismissButton: XCUIElement {
        return springboard.buttons["Dismiss"].firstMatch
    }
    var actionButton: XCUIElement {
        return springboard.buttons["ACTION"].firstMatch
    }
}
