//
//  PushNotificationExtension.swift
//  TestingPushNotificationsUITests
//
//  Created by Nicolás García on 13-02-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import Foundation
import XCTest
import NWPusher

extension XCTestCase {
    
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
