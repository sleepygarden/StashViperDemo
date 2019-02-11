//
//  AchievementsViewTests.swift
//  StashCoachTests
//
//  Created by Michael Cornell on 2/10/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import FBSnapshotTestCase
@testable import StashCoach

final class AchievementsViewTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }

    // mcornell 2/10/19 - typically I'd no expose all of the subview members of the view just for testing purposes - i'd use snapshot testing and render them into that
    func testSetsUpCells() {
        let view = AchievementsViewController()
        
        let title = "Title"
        let achievements = [
            Achievement(id: "1", level: "1", progress: 10, total: 50, bgImageURLString: nil, accessible: true)
        ]
        
        view.view.frame = DeviceFrames.iPhone7
        view.showAchievements(achievements, title: title, animated: false)
        
        FBSnapshotVerifyView(view.view)
    }
    
    func testSetsUpAwaitingView() {
        let view = AchievementsViewController()
        
        view.view.frame = DeviceFrames.iPhone7
        view.showAwaitingContent(animated: false)
        
        FBSnapshotVerifyView(view.view)
    }
    
    func testSetsUpNoContentView() {
        let view = AchievementsViewController()
        
        view.view.frame = DeviceFrames.iPhone7
        view.showNoContent(animated: false)
        
        FBSnapshotVerifyView(view.view)
    }
}


