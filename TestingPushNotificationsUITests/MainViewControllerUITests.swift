////
////  MainViewControllerUITests.swift
////  TestingPushNotificationsUITests
////
////  Created by Nicolás García on 01-02-18.
////  Copyright © 2018 Nicolas Garcia. All rights reserved.
////
//
//import XCTest
//import PushKit
//import NWPusher
//
//final class MainViewControllerUITests: XCTestCase {
//
//    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
//
//    override func setUp() {
//        super.setUp()
//
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDown() {
//        super.tearDown()
//    }
//
//
////    func testNotificationCenterInteractions() {
////        let app = XCUIApplication()
////        app.launchArguments.append("isRunningUITests")
////        app.launch()
////
////        XCUIDevice.shared.press(XCUIDevice.Button.home)
////        sleep(1)
////
////        let statusBarsQuery = springboard.statusBars
////        let orientationLockedElement = statusBarsQuery.otherElements["Orientation Locked"]
////        orientationLockedElement.swipeDown()
////        orientationLockedElement.tap()
////
////        sleep(5)
////    }
//
//}
//
//
