//
//  AppDelegate.swift
//  TestingPushNotifications
//
//  Created by Nicolás García on 03-01-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let notificationTapAction = "com.apple.UNNotificationDefaultActionIdentifier"
    let notificationDismissAction = "com.apple.UNNotificationDismissActionIdentifier"
    let notificationAction = "notificationAction"
    let notificationCategory = "notificationCategory"
    let center = UNUserNotificationCenter.current()
    
    
    let notificationTextInputCategory = "notificationTextInputCategory"
    let notificationTextInputActionIdentifier = "notificationTextInputAction"
    let notificationTextInputSendAction = "notificationTextInputSendAction"
    
    let notificationTextInputActionTitle = "Add Comment"
    let notificationTextInputButtonTitle = "Send"
    let notificationTextInputPlaceholder = "Add Comment Here"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        registerForPushNotifications()
    
        let action = UNNotificationAction(identifier: notificationAction,
                                                    title: "ACTION",
                                                    options: [.foreground])
        
        let category = UNNotificationCategory(identifier: notificationCategory,
                                                   actions: [action],
                                                   intentIdentifiers: [],
                                                   options: .customDismissAction)
        
        let textInputAction = UNTextInputNotificationAction(identifier: notificationTextInputActionIdentifier, title: notificationTextInputActionTitle, options: [], textInputButtonTitle: notificationTextInputButtonTitle, textInputPlaceholder: notificationTextInputPlaceholder)
        
//        let textInputSendAction = UNNotificationAction(identifier: notificationTextInputSendAction,
//                                          title: "SEND",
//                                          options: [.foreground])
        
        let textInputCategory = UNNotificationCategory(identifier: notificationTextInputCategory,
                                                       actions: [textInputAction],
                                                       intentIdentifiers: [],
                                                       options: .customDismissAction)


        center.setNotificationCategories([category, textInputCategory])
        center.delegate = self

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
            guard granted else { return }
            
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else { return }
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        
//        if ProcessInfo.processInfo.arguments.contains("isRunningUITests") {
//
//            NotificationCenter.default.post(name: didRegisterWithDeviceTokenNotification, object: token)
//        }
        
        NotificationCenter.default.post(name: didRegisterWithDeviceTokenNotification, object: token)
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
//    func application(
//        _ application: UIApplication,
//        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//
////        handle(userInfo)
//
//    }
//
//    func handle(_ pushNotification: [AnyHashable: Any]) {
//        NotificationCenter.default.post(name: bikeTheftNotification, object: pushNotification)
//    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        switch response.notification.request.content.categoryIdentifier {
        case notificationCategory:
            switch response.actionIdentifier {
            case notificationAction:
                print("User pressed ACTION button from notification")
                NotificationCenter.default.post(name: bikeTheftNotification, object: response.notification.request.content.userInfo)
                completionHandler()

            case notificationTapAction:
                print("User has tapped notification")
                NotificationCenter.default.post(name: bikeTheftNotification, object: response.notification.request.content.userInfo)
                completionHandler()

            case notificationDismissAction:
                print("User has dismissed the notification")
                completionHandler()
                
            default:
                completionHandler()
            }
        case notificationTextInputCategory:
            switch response.actionIdentifier {
            case notificationTextInputActionIdentifier:
                print("User did send a message through the notification")
                completionHandler()
                
            default:
                completionHandler()
            }
            
        default:
            print("User has tapped a notification without category")
            completionHandler()
        }
    }

}

