//
//  AchievementsTestHelpers.swift
//  StashCoachTests
//
//  Created by Michael Cornell on 2/10/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation
import XCTest
@testable import StashCoach

struct DeviceFrames {
    static let iPhone7 = CGRect(x: 0, y: 0, width: 375, height: 667)
}

final class MockAchievementsWireframe: AchievementsWireframe {
    
    static func createAchievementsModule(session: STSession, requestBuilder: RequestBuilder) -> UIViewController {
        return MockAchievementsView(nibName: nil, bundle: nil)
    }
    
    func presentAchievementInfo(in viewController: AchievementsView, animated: Bool) {
        guard let viewController = viewController as? MockAchievementsView else {
            return
        }
        viewController.infoIsPresented = true
    }
    
    func presentAchievementDetail(achievement: Achievement, in viewController: AchievementsView, animated: Bool) {
        guard let viewController = viewController as? MockAchievementsView else {
            return
        }
        viewController.detailIsPresented = true
    }
}

final class MockAchievementsView: UIViewController, AchievementsView {
    
    enum State {
        case none
        case awaiting
        case showing
        case noneToShow
    }
    
    var currentViewMode: State = .none
    var infoIsPresented = false
    var detailIsPresented = false
    
    var presenter: AchievementsPresenter?
    
    func showAchievements(_ achievements: [Achievement], title: String, animated: Bool) {
        currentViewMode = .showing
    }
    
    func showAwaitingContent(animated: Bool) {
        currentViewMode = .awaiting
    }
    
    func showNoContent(animated: Bool) {
        currentViewMode = .noneToShow
    }
}

final class MockAchievementsInteractor: AchievementsInteractor {
    
    enum MockError: Error {
        case error
    }
    
    var stubbedAchievements: [Achievement]?
    var stubbedPreCompletionBlock: (() -> Void)?
    weak var outputDelegate: AchievementsInteractorDelegate?
    
    
    func retrieveAchievements() {
        if let stubbed = stubbedAchievements {
            outputDelegate?.interactorDidRetrieveAchievements(title: "woolsuit", achievements: stubbed)
        }
        else {
            outputDelegate?.interactorFailedToRetrieveAchievements(error: MockError.error)
        }
    }
}
