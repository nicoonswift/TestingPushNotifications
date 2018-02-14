//
//  TestingPushNotificationsUITests.swift
//  TestingPushNotificationsUITests
//
//  Created by Nicolás García on 03-01-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import XCTest

final class TestingPushNotificationsUITests: XCTestCase {
    
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTapNotificationWithoutCategory() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        // dismiss the system dialog if it pops up
        allowPushNotificationsIfNeeded(app: app)
        
        let notificationsPermissionButton = app.buttons["notificationsButton"]
        notificationsPermissionButton.tap()
        
        // get the current deviceToken from the app
        let deviceTokenLabel = app.staticTexts.element(matching: .any, identifier: "deviceTokenLabel")
        XCTAssert(deviceTokenLabel.waitForExistence(timeout: 10))
        
        let deviceToken = deviceTokenLabel.label
        
        // close app
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        
        // trigger red Push Notification
        let latitude = 47.2256013
        let longitude = -1.5633523
        
        let payload = "{\"aps\":{\"alert\":\"Your bike was stolen!\"}, \"latitude\":\(latitude), \"longitude\":\(longitude)}"
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        let notification = springboard.otherElements["NotificationShortLookView"]
        XCTAssert(notification.waitForExistence(timeout: 10))

//        let notification = springboard.otherElements["TESTINGPUSHNOTIFICATIONS, now, Your bike was stolen!"]
        notification.tap()
        
        //Give time to see how the app reacts
        sleep(3)
    }
    
    func testTapNotificationActionButton() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        // dismiss the system dialog if it pops up
        allowPushNotificationsIfNeeded(app: app)
        
        let notificationsPermissionButton = app.buttons["notificationsButton"]
        notificationsPermissionButton.tap()
        
        // get the current deviceToken from the app
        let deviceTokenLabel = app.staticTexts.element(matching: .any, identifier: "deviceTokenLabel")
        XCTAssert(deviceTokenLabel.waitForExistence(timeout: 10))
        
        let deviceToken = deviceTokenLabel.label
        
        // close app
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        
        // trigger red Push Notification
        let latitude = 47.2256013
        let longitude = -1.5633523
        
        let payload = "{\"aps\":{\"alert\":\"Your bike was stolen!\", \"category\":\"notificationCategory\"}, \"latitude\":\(latitude), \"longitude\":\(longitude)}"
        
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        let notification = springboard.otherElements["NotificationShortLookView"]
        XCTAssert(notification.waitForExistence(timeout: 10))
        notification.swipeDown()
        
        //Case 2a: Tap on Action Button
        let actionableNotification = SpringBoardActionableNotification(springboard: springboard)
        XCTAssert(actionableNotification.actionButton.exists)
        actionableNotification.actionButton.tap()
        
        let alert = app.alerts["Bonjour !"]
        XCTAssert(alert.waitForExistence(timeout: 10))

        //Give time to see how the app reacts
        sleep(3)
    }
    
    func testTapActionableNotification() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        // dismiss the system dialog if it pops up
        allowPushNotificationsIfNeeded(app: app)
        
        let notificationsPermissionButton = app.buttons["notificationsButton"]
        notificationsPermissionButton.tap()
        
        // get the current deviceToken from the app
        let deviceTokenLabel = app.staticTexts.element(matching: .any, identifier: "deviceTokenLabel")
        XCTAssert(deviceTokenLabel.waitForExistence(timeout: 10))
        
        let deviceToken = deviceTokenLabel.label
        
        // close app
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        
        // trigger red Push Notification
        let latitude = 47.2256013
        let longitude = -1.5633523
        
        let payload = "{\"aps\":{\"alert\":\"Your bike was stolen!\", \"category\":\"notificationCategory\"}, \"latitude\":\(latitude), \"longitude\":\(longitude)}"
        
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        let notification = springboard.otherElements["NotificationShortLookView"]
        XCTAssert(notification.waitForExistence(timeout: 10))
        notification.swipeDown()
        
        //Case: Tap on notification body
        let actionableNotification = SpringBoardActionableNotification(springboard: springboard)
        XCTAssert(actionableNotification.messageButton.exists)
        actionableNotification.messageButton.tap()
        
        //Give time to see how the app reacts
        sleep(10)
    }
    
    func testCloseActionbleNotification() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        // dismiss the system dialog if it pops up
        allowPushNotificationsIfNeeded(app: app)
        
        let notificationsPermissionButton = app.buttons["notificationsButton"]
        notificationsPermissionButton.tap()
        
        // get the current deviceToken from the app
        let deviceTokenLabel = app.staticTexts.element(matching: .any, identifier: "deviceTokenLabel")
        XCTAssert(deviceTokenLabel.waitForExistence(timeout: 10))
        
        let deviceToken = deviceTokenLabel.label
        
        // close app
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        
        // trigger red Push Notification
        let latitude = 47.2256013
        let longitude = -1.5633523
        
        let payload = "{\"aps\":{\"alert\":\"Your bike was stolen!\", \"category\":\"notificationCategory\"}, \"latitude\":\(latitude), \"longitude\":\(longitude)}"
        
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        let notification = springboard.otherElements["NotificationShortLookView"]
        XCTAssert(notification.waitForExistence(timeout: 10))
        notification.swipeDown()
        
        //Case: Dismiss notification
        let actionableNotification = SpringBoardActionableNotification(springboard: springboard)
        XCTAssert(actionableNotification.dismissButton.exists)
        actionableNotification.dismissButton.tap()
    }
    
    func testTextInputActionbleNotification() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        // dismiss the system dialog if it pops up
        allowPushNotificationsIfNeeded(app: app)
        
        let notificationsPermissionButton = app.buttons["notificationsButton"]
        notificationsPermissionButton.tap()
        
        // get the current deviceToken from the app
        let deviceTokenLabel = app.staticTexts.element(matching: .any, identifier: "deviceTokenLabel")
        XCTAssert(deviceTokenLabel.waitForExistence(timeout: 10))

        let deviceToken = deviceTokenLabel.label

        // close app
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        
        // trigger red Push Notification
        let payload = "{\"aps\":{\"alert\":\"You have a message!\", \"category\":\"notificationTextInputCategory\"}}"
        
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        //Display notification
        let notification = springboard.otherElements["NotificationShortLookView"]
        XCTAssert(notification.waitForExistence(timeout: 10))
        notification.swipeDown()
        
        //Case: Send message through notification
        let actionableNotification = SpringBoardActionableTextInputNotification(springboard: springboard)
        
        XCTAssert(actionableNotification.textField.exists)
        actionableNotification.textField.typeText("this is a test message")
        
        XCTAssert(actionableNotification.sendButton.exists)
        actionableNotification.sendButton.tap()
    }
    
}
