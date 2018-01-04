//
//  MainViewController.swift
//  TestingPushNotifications
//
//  Created by Nicolás García on 04-01-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import UIKit
import UserNotifications


final class MainViewController: UIViewController {
    
    var deviceTokenLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.handleNotification(_:)), name: didRegisterWithDeviceTokenNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.handleNotification(_:)), name: bikeTheftNotification, object: nil)
    }
    
    /*
     NSNotification allows us to access notificacion's name and object properties.
    */
    @objc func handleNotification(_ notification: NSNotification) {
        
        switch notification.name {
        case didRegisterWithDeviceTokenNotification:
            guard let deviceToken = notification.object as? String else {
                //TODO: handle error
                return
            }
            
            if deviceTokenLabel == nil {
                let deviceTokenLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                deviceTokenLabel.accessibilityIdentifier = "deviceTokenLabel"
                view.addSubview(deviceTokenLabel)
                self.deviceTokenLabel = deviceTokenLabel
                self.deviceTokenLabel?.text = deviceToken
            }
            
        case bikeTheftNotification:
            let storyboard = UIStoryboard(name: "Theft", bundle: nil)
            let theftViewController = storyboard.instantiateViewController(withIdentifier: "TheftViewController") as! TheftViewController
            self.present(theftViewController, animated: true, completion: {})
            
        default:
            break
        }
        
//        let alert = UIAlertController(title: "test", message: "test", preferredStyle: .alert)
//        self.present(alert, animated: true, completion: {})
    }

}
