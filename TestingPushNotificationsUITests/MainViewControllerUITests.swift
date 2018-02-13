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

    func testTextInputActionbleNotification() {
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
        let payload = "{\"aps\":{\"alert\":\"You have a message!\", \"category\":\"notificationTextInputCategory\"}}"
        
        triggerPushNotification(
            withPayload: payload,
            deviceToken: deviceToken)
        
        sleep(3)
        
        let notification = springboard.otherElements["TESTINGPUSHNOTIFICATIONS, now, You have a message!"]
        
        //Case 2: To display notification's category available actions
        notification.swipeDown()
        
        //Case 2d: Dismiss on notification
        let actionableNotification = SpringBoardActionableTextInputNotification(springboard: springboard)

        XCTAssert(actionableNotification.textField.exists)
        actionableNotification.textField.typeText("this is a test message")
        
        XCTAssert(actionableNotification.sendButton.exists)
        actionableNotification.sendButton.tap()
        
        //      Other, 0x1c4390400, traits: 35192962023424, {{0.0, 8.0}, {375.0, 659.0}}, label: 'Notification'

        //      Other, 0x1c058fa40, traits: 35192962023424, {{0.0, 575.0}, {375.0, 92.0}}, label: 'Dock'

        sleep(5)
    }
    
    struct PanelControl {
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
    
    func testPanelControl() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()
        
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(1)
        
        let dock = springboard.otherElements["Dock"]
        dock.swipeUp()
        
        sleep(1)
        
        let panelControl = PanelControl(springboard: springboard)
        panelControl.cellularDataButtonSwitch.tap()
        panelControl.cellularDataButtonSwitch.tap()

        panelControl.wifiButton.tap()
        panelControl.wifiButton.tap()

        panelControl.bluetoothButton.tap()
        panelControl.bluetoothButton.tap()

        panelControl.airplaneModeButtonSwitch.tap()
        panelControl.airplaneModeButtonSwitch.tap()

        panelControl.flashlightButton.tap()
        panelControl.flashlightButton.tap()

        panelControl.doNotDisturbSwitch.tap()
        panelControl.doNotDisturbSwitch.tap()

        panelControl.orientationLockSwitch.tap()
        panelControl.orientationLockSwitch.tap()

        panelControl.closeButton.tap()
        
        
//        let statusBarsQuery = springboard.statusBars
//        statusBarsQuery.otherElements["Orientation Locked"].tap()
        
        
//        springboard.otherElements["ControlCenterView"].children(matching: .other).element(boundBy: 0).tap()
    }
    
    func testNotificationCenterControl() {
        let app = XCUIApplication()
        app.launchArguments.append("isRunningUITests")
        app.launch()

        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(1)

        
        
        
        
//        let controlCenterLayoutView = app/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"ControlCenterView\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.scrollViews["ControlCenterLayoutView"].otherElements
//        let elementsQuery = controlCenterLayoutView.scrollViews.otherElements
//
//        let cellularDataButtonSwitch = elementsQuery/*@START_MENU_TOKEN@*/.switches["cellular-data-button"]/*[[".switches[\"Cellular Data\"]",".switches[\"cellular-data-button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        cellularDataButtonSwitch.tap()
//        cellularDataButtonSwitch.tap()
//
//        let wifiButton = elementsQuery/*@START_MENU_TOKEN@*/.switches["wifi-button"]/*[[".switches[\"Wi-Fi, Bbox-7D26BA\"]",".switches[\"wifi-button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        wifiButton.tap()
//        wifiButton.tap()
//
//        let bluetoothButton = elementsQuery/*@START_MENU_TOKEN@*/.switches["bluetooth-button"]/*[[".switches[\"Bluetooth, Not Connected\"]",".switches[\"bluetooth-button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        bluetoothButton.tap()
//        bluetoothButton.tap()
//
//        let airplaneModeButtonSwitch = elementsQuery/*@START_MENU_TOKEN@*/.switches["airplane-mode-button"]/*[[".switches[\"Airplane Mode\"]",".switches[\"airplane-mode-button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        airplaneModeButtonSwitch.tap()
//        airplaneModeButtonSwitch.tap()
//
//        let flashlightButton = controlCenterLayoutView/*@START_MENU_TOKEN@*/.buttons["flashlight"]/*[[".buttons[\"Flashlight\"]",".buttons[\"flashlight\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        flashlightButton.tap()
//        flashlightButton.tap()
//
//        let doNotDisturbSwitch = controlCenterLayoutView/*@START_MENU_TOKEN@*/.switches["do-not-disturb"]/*[[".switches[\"Do not disturb\"]",".switches[\"do-not-disturb\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        doNotDisturbSwitch.tap()
//        doNotDisturbSwitch.tap()
//
//        let orientationLockSwitch = controlCenterLayoutView/*@START_MENU_TOKEN@*/.switches["orientation-lock"]/*[[".switches[\"Lock Rotation\"]",".switches[\"orientation-lock\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        orientationLockSwitch.tap()
//        orientationLockSwitch.tap()
//
//        let statusBarsQuery = app.statusBars
//        statusBarsQuery.otherElements["Orientation Locked"].tap()
//
//
//        app.otherElements["ControlCenterView"].children(matching: .other).element(boundBy: 0).tap()
        
  
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
