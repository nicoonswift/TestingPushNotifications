//
//  MainViewControllerUITests.swift
//  TestingPushNotificationsUITests
//
//  Created by Nicolás García on 01-02-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import XCTest
import PushKit
import NWPusher

final class MainViewControllerUITests: XCTestCase {
    
    // access to the springboard (to be able to tap the notification later) [1]
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
        super.tearDown()
    }
    
    func testTapNotification() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        // dismiss the system dialog if it pops up
        allowPushNotificationsIfNeeded()
        
        // get the current deviceToken from the app [2]
        let deviceToken = app.staticTexts.element(matching: .any, identifier: "deviceTokenLabel").label
        
        // close app [3]
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(1)
        
        
        // trigger red Push Notification [4]
        let latitude = 47.2256013
        let longitude = -1.5633523
        
//        let payload = "{\"aps\":{\"alert\":\"Your bike was stolen!\", \"category\":\"notificationCategory\"}, \"latitude\":\(latitude), \"longitude\":\(longitude)}"
        let payload = "{\"aps\":{\"alert\":\"Your bike was stolen!\"}, \"latitude\":\(latitude), \"longitude\":\(longitude)}"
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        sleep(3)
        
        let notification = springboard.otherElements["TESTINGPUSHNOTIFICATIONS, now, Your bike was stolen!"]
        //Case 1: Normal tap on notification
        notification.tap()

        sleep(5)
    }
    
    func testTapNotificationAction() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        // dismiss the system dialog if it pops up
        allowPushNotificationsIfNeeded()
        
        // get the current deviceToken from the app [2]
        let deviceToken = app.staticTexts.element(matching: .any, identifier: "deviceTokenLabel").label
        
        // close app [3]
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(1)
        
        // trigger red Push Notification [4]
        let latitude = 47.2256013
        let longitude = -1.5633523
        
        let payload = "{\"aps\":{\"alert\":\"Your bike was stolen!\", \"category\":\"notificationCategory\"}, \"latitude\":\(latitude), \"longitude\":\(longitude)}"
        
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        sleep(3)
        
        let notification = springboard.otherElements["TESTINGPUSHNOTIFICATIONS, now, Your bike was stolen!"]
        
        //Case 2: To display notification's category available actions
        notification.swipeDown()
        
        //Case 2a: Tap on Action 1
        let actionableNotification = SpringBoardActionableNotification(springboard: springboard)
        XCTAssert(actionableNotification.actionButton.exists)
        actionableNotification.actionButton.tap()
        
        sleep(5)
    }
    
    func testTapActionableNotification() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        // dismiss the system dialog if it pops up
        allowPushNotificationsIfNeeded()
        
        // get the current deviceToken from the app [2]
        let deviceToken = app.staticTexts.element(matching: .any, identifier: "deviceTokenLabel").label
        
        // close app [3]
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(1)
        
        // trigger red Push Notification [4]
        
        let latitude = 47.2256013
        let longitude = -1.5633523
        
        let payload = "{\"aps\":{\"alert\":\"Your bike was stolen!\", \"category\":\"notificationCategory\"}, \"latitude\":\(latitude), \"longitude\":\(longitude)}"
        
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        sleep(3)
        
        let notification = springboard.otherElements["TESTINGPUSHNOTIFICATIONS, now, Your bike was stolen!"]
        
        //Case 2: To display notification's category available actions
        notification.swipeDown()
        
        //Case 2c: Tap on notification
        let actionableNotification = SpringBoardActionableNotification(springboard: springboard)
        XCTAssert(actionableNotification.messageButton.exists)
        actionableNotification.messageButton.tap()
 
        sleep(5)
    }
    
    func testCloseActionbleNotification() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        // dismiss the system dialog if it pops up
        allowPushNotificationsIfNeeded()
        
        // get the current deviceToken from the app [2]
        let deviceToken = app.staticTexts.element(matching: .any, identifier: "deviceTokenLabel").label
        
        // close app [3]
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(1)
        
        // trigger red Push Notification [4]
        
        let latitude = 47.2256013
        let longitude = -1.5633523
        
        let payload = "{\"aps\":{\"alert\":\"Your bike was stolen!\", \"category\":\"notificationCategory\"}, \"latitude\":\(latitude), \"longitude\":\(longitude)}"
        
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        sleep(3)
        
        let notification = springboard.otherElements["TESTINGPUSHNOTIFICATIONS, now, Your bike was stolen!"]
        
        //Case 2: To display notification's category available actions
        notification.swipeDown()
        
        //Case 2d: Dismiss on notification
        let actionableNotification = SpringBoardActionableNotification(springboard: springboard)
        XCTAssert(actionableNotification.dismissButton.exists)
        actionableNotification.dismissButton.tap()
        
        sleep(5)
    }

    
    func triggerPushNotification(withPayload payload: String, deviceToken: String) {
        let uiTestBundle = Bundle(for: TestingPushNotificationsUITests.self)
        guard let url = uiTestBundle.url(forResource: "apns_dev.p12", withExtension: nil) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let pusher = try NWPusher.connect(withPKCS12Data: data, password: "cocoaheadsnantes", environment: .auto)
            try pusher.pushPayload(payload, token: deviceToken,
                                   identifier: UInt(arc4random_uniform(UInt32(999))))
        } catch {
            print(error)
        }
    }
    
    func allowPushNotificationsIfNeeded() {
        addUIInterruptionMonitor(withDescription: "“RemoteNotification” Would Like to Send You Notifications") { (alerts) -> Bool in
            if(alerts.buttons["Allow"].exists){
                alerts.buttons["Allow"].tap()
                return true
            }
            return false
        }
        XCUIApplication().tap()
    }
    
}
