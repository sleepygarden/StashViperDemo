//
//  AchievementsInteractorTests.swift
//  StashCoachTests
//
//  Created by Michael Cornell on 2/10/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import XCTest
@testable import StashCoach

final class MockAchievementsInteractorDelegate: AchievementsInteractorDelegate {
    
    var didSucceed = false
    var didFail = false
    
    func interactorDidRetrieveAchievements(title: String, achievements: [Achievement]) {
        didSucceed = true
    }
    
    func interactorFailedToRetrieveAchievements(error: Error) {
        didFail = true
    }
}

final class AchievementsInteractorTests: XCTestCase {
    
    func testRetrievesAchievements() {
        let interactor = AchievementsInteractorImplementation(session: FileSession(), requestBuilder: RequestBuilder(root: "https://www.sleepy.nyc"))
        let output = MockAchievementsInteractorDelegate()
        interactor.outputDelegate = output
        interactor.retrieveAchievements()
        
        XCTAssertTrue(output.didSucceed, "The success output method should have fired")
        XCTAssertFalse(output.didFail, "The failure output method should not have fired")

    }
    
    func testReportsFailures() {
        let interactor = AchievementsInteractorImplementation(session: MockSTSession(), requestBuilder: RequestBuilder(root: "www.sleepy.nyc"))
        let output = MockAchievementsInteractorDelegate()
        interactor.outputDelegate = output
        interactor.retrieveAchievements()
        
        XCTAssertFalse(output.didSucceed, "The success output method should not have fired")
        XCTAssertTrue(output.didFail, "The failure output method should have fired")

    }
}
