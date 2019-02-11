//
//  AchievementResponseProcessorTests.swift
//  StashCoachTests
//
//  Created by Michael Cornell on 2/6/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import XCTest
@testable import StashCoach


class AchievementResponseProcessorTests: XCTestCase {
    
    func testParsesAchievements() {
        let passedInTitle = "woolsuit"
        let id = 3
        let level = "2"
        let progress = 0
        let total = 50
        let bgImageURL = "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/341E40C8-1C2A-400C-B67D-F490B74BDD81.png"
        let accessible = false
        let validJSON: [String: Any] = [
            "overview": [
                "title": passedInTitle
            ],
            "achievements": [
                [
                    "id": id,
                    "level": level,
                    "progress": progress,
                    "total": total,
                    "bg_image_url": bgImageURL,
                    "accessible": accessible
                ]
            ]
        ]
        
        var achievements: [Achievement]? = nil
        var title: String? = nil
        let parser = AchievementsResponseProcessor({ (response) in
            switch response {
            case .error(_):
                break // pass
            case .value(let respValue):
                title = respValue.title
                achievements = respValue.achievements
            }
        })
        
        parser.processResponse(.value(validJSON))
        
        XCTAssertEqual(title, passedInTitle, "Title should have been parsed")
        XCTAssertNotNil(achievements, "Achievements should have been parsed")
        XCTAssertEqual(achievements?.count, 1, "Achievements should be an array with one member")
        
        let firstParsedAchievement = achievements?.first
        
        XCTAssertEqual(firstParsedAchievement?.id, "\(id)", "Achievement should have parsed all members")
        XCTAssertEqual(firstParsedAchievement?.bgImageURL, URL(string: bgImageURL)!, "Achievement should have parsed all members")
    }
    
    func testRejectsInvalidJSON() {
        let invalidJSON = ["hi": "friends"]
        
        var error: Error? = nil
        let parser = AchievementsResponseProcessor({ (response) in
            switch response {
            case .error(let respError):
                error = respError
            case .value(_):
                break // pass
            }
        })
        
        parser.processResponse(.value(invalidJSON))
        
        guard let parseError = error, case AchievementsResponseProcessorError.invalidData = parseError else {
            XCTFail("Invalid JSON payloads should report an error")
            return
        }
    }
}

