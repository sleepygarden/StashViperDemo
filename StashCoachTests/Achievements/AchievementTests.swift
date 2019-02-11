//
//  AchievementTests.swift
//  StashCoachTests
//
//  Created by Michael Cornell on 2/10/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import XCTest
@testable import StashCoach


class AchievementTests: XCTestCase {
    
    func testInitsWithJSON() {
        let id = 10
        let level = "1"
        let progress = 10
        let total = 50
        let bgImageURL = "https://www.sleepy.com"
        let accessible = true
        
        let validJSON: [String: Any] = [
            "id": id,
            "level": level,
            "progress": progress,
            "total": total,
            "bg_image_url": bgImageURL,
            "accessible": accessible
        ]
        
        let achievement = Achievement(dictionary: validJSON)
        XCTAssertNotNil(achievement, "Achievement should be built out of valid json")
        XCTAssertEqual(achievement?.bgImageURL, URL(string: bgImageURL)!, "Achievement should save its members")
    }
    
    func testRejectsBadJSON() {
        let badJSON = ["foo": "bar"]
        
        let achievement = Achievement(dictionary: badJSON)
        XCTAssertNil(achievement, "Achievement should not be built with invalid JSON")
    }
}

