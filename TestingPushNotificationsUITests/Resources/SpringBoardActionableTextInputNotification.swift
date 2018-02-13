//
//  SpringBoardActionableTextInputNotification.swift
//  TestingPushNotificationsUITests
//
//  Created by Nicolás García on 13-02-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import Foundation
import XCTest

struct SpringBoardActionableTextInputNotification {
    
    let springboard: XCUIApplication
    
    var titleButton: XCUIElement {
        return springboard.buttons["TESTINGPUSHNOTIFICATIONS"].firstMatch
    }
    var messageButton: XCUIElement {
        return springboard.buttons["You have a message!"].firstMatch
    }
    var dismissButton: XCUIElement {
        return springboard.buttons["Dismiss"].firstMatch
    }
    var sendButton: XCUIElement {
        return springboard.buttons["Send"].firstMatch
    }
    var textField: XCUIElement {
        return springboard.textFields["Add Comment Here"].firstMatch
    }
}
