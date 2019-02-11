//
//  AchievementsWireframeTests.swift
//  StashCoachTests
//
//  Created by Michael Cornell on 2/10/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import XCTest
@testable import StashCoach

final class AchievementsWireframeTests: XCTestCase {

    func testDetailVCIsPresented() {
        guard let navController = AchievementsWireframeImplementation.createAchievementsModule(session: MockSTSession(), requestBuilder: RequestBuilder(root: "https://www.sleepy.nyc")) as? AchievementsNavigationController else {
            XCTFail("AchievementsWireframe create module should return an opaque UIViewController which is internally an AchievementsNavigationController")
            return
        }
        
        guard let view = navController.topViewController as? AchievementsView else {
            XCTFail("AchievementsWireframe create module should place an AchievementsView at the root of the navigaiton stack")
            return
        }
        
        guard let wireframe = view.presenter?.wireframe else {
            XCTFail("Achievements module should come with its components connected together")
            return
        }
        
        let achievement = Achievement(id: "1", level: "1", progress: 0, total: 50, bgImageURLString: "https://www.sleepy.nyc", accessible: false)

        wireframe.presentAchievementDetail(achievement: achievement, in: view, animated: false)
        
        // mcornell 2/10/19 - outside of this demo app, this would assert a real view controller class
        XCTAssert(navController.topViewController?.isKind(of: UnfinishedFeatureViewController.self) == true, "Wireframe should have presented an UnfinishedFeatureViewController")
    }
    
    func testInfoVCIsPresented() {
        guard let navController = AchievementsWireframeImplementation.createAchievementsModule(session: MockSTSession(), requestBuilder: RequestBuilder(root: "https://www.sleepy.nyc")) as? AchievementsNavigationController else {
            XCTFail("AchievementsWireframe create module should return an opaque UIViewController which is internally an AchievementsNavigationController")
            return
        }
        
        guard let view = navController.topViewController as? AchievementsView else {
            XCTFail("AchievementsWireframe create module should place an AchievementsView at the root of the navigaiton stack")
            return
        }
        
        guard let wireframe = view.presenter?.wireframe else {
            XCTFail("Achievements module should come with its components connected together")
            return
        }
        
        wireframe.presentAchievementInfo(in: view, animated: false)
        
        // mcornell 2/10/19 - outside of this demo app, this would assert a real view controller class
        XCTAssert(navController.topViewController?.isKind(of: UnfinishedFeatureViewController.self) == true, "Wireframe should have presented an UnfinishedFeatureViewController")
    }
}
