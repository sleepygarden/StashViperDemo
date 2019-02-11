//
//  AchievementsPresenterTests.swift
//  StashCoachTests
//
//  Created by Michael Cornell on 2/10/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import XCTest
@testable import StashCoach

final class AchievementsPresenterTests: XCTestCase {
    
    
    func testChangesViewStateWithAchievements() {
        let view = MockAchievementsView()
        let interactor = MockAchievementsInteractor()
        
 
        interactor.stubbedAchievements = [
            Achievement(id: "1", level: "1", progress: 10, total: 50, bgImageURLString: "foo", accessible: true)
        ]
        
        let wireframe = MockAchievementsWireframe()
        let presenter = AchievementsPresenter(view: view, interactor: interactor, wireframe: wireframe)
        view.presenter = presenter
        
        interactor.stubbedPreCompletionBlock = {
            XCTAssert(view.currentViewMode == .awaiting, "After updateView has been called, before the interactor has completed, the presenter should put the view into an awaiting state")
        }
        
        presenter.updateView()
        
        XCTAssert(view.currentViewMode == .showing)
    }
    
    func testChangesViewStateWithNoAchievements() {
        let view = MockAchievementsView()
        let interactor = MockAchievementsInteractor()
        let wireframe = MockAchievementsWireframe()
        let presenter = AchievementsPresenter(view: view, interactor: interactor, wireframe: wireframe)
        view.presenter = presenter
        
        interactor.stubbedPreCompletionBlock = {
            XCTAssert(view.currentViewMode == .awaiting, "After updateView has been called, before the interactor has completed, the presenter should put the view into an awaiting state")
        }
        
        presenter.updateView()
        
        XCTAssert(view.currentViewMode == .noneToShow)
    }
}
