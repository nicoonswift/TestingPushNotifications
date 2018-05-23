# UITesting: Dealing with Push Notifications

![Platforms](https://img.shields.io/badge/platform-iOS-blue.svg)
![Swift version](https://img.shields.io/badge/swift-4.0-blue.svg)

Talk given at [CocoaHeads Nantes](https://www.meetup.com/fr-FR/CocoaHeads-Nantes/) 15/02/2018

[Talk's keynote](https://speakerdeck.com/nicoonguitar/ui-testing-dealing-with-push-notifications)

Based on [Jörn Schoppe](http://www.pixeldock.com/blog/testing-push-notifications-with-xcode-uitests/) 
idea for testing push notifications with UI Tests, 
I took a step forward in order to handle notifications with actions and text inputs. 
In the project the notifications are handled from the Springboard, but by using 
[userNotificationCenter(_:willPresent:withCompletionHandler:)](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate/1649518-usernotificationcenter)
we could interact with the received notifications while the app is in the foreground.

Also a UI Test example on interacting with the Control Center from the Springboard is added.

## Getting Started

### Prerequisites

- Xcode 9.3
- Swift 4.0
- iOS 11.2.5+
- CocoaPods

## Running the project
Remember to setup the app in Apple Developer website

* Create the project's AppID (or set a new one) on your Apple's developer account 
* Generate APNS certificate for development environment 
* Add certificate to Keychain and extract the .p12 file from it. Don´t forget the password !
* Add the .p12 to UITest project's target.
* Remember to setup NWPusher to push the payload in sandbox environment

## Videos

* [UI Testing: Controlling Control Center iOS 11.2.5](https://youtu.be/BTf53VsqnpE)
* [UI Testing: Push Notification with a Text Input Action iOS 11.2.5](https://youtu.be/sdm8101hjXUUI)
* [Testing: Push Notification with an Action iOS 11.2.5](https://youtu.be/TUn2HcCgeYcUI)
* [Testing: Push Notification tap from Springboard iOS 11.2.5](https://youtu.be/gbKuLK5chpU)
* [UI Testing: Push Notification dismiss from Springboard iOS 11.2.5](https://youtu.be/mZ_dv0e7274)
 
 
 ## Links of interest
 
 * [Using iMessages app on Simulator to test Deep Linking](https://blog.branch.io/ui-testing-universal-links-in-xcode-9/)
 * [Xcode 9 XCTest new features](https://medium.com/xcblog/hands-on-xcuitest-features-with-xcode-9-eb4d00be2781)

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

- *Nicolas Garcia* [GitHub](https://github.com/nigarcia88)

