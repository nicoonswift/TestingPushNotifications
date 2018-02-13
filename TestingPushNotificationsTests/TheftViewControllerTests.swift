//
//  TheftViewControllerTests.swift
//  TestingPushNotificationsTests
//
//  Created by Nicolás García on 03-01-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import XCTest
@testable import TestingPushNotifications

final class TheftViewControllerTests: XCTestCase {
    
    var sut: TheftViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Theft",
                                      bundle: nil)
        XCTAssertNotNil(storyboard)
        sut = storyboard
            .instantiateViewController(
                withIdentifier: "TheftViewController")
            as! TheftViewController
        let navigationController = UINavigationController()
        navigationController.viewControllers = [sut]
        UIApplication.shared.keyWindow!.rootViewController = navigationController
        XCTAssertNotNil(sut.view)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_hasMapView() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func test_mapViewHasDelegate() {
        XCTAssertNotNil(sut.mapView?.delegate)
    }
    
}
