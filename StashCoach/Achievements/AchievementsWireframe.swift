//
//  AchievementsWireframe.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/6/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit

/// AchievementsWireframe - the wireframe for the Achievements module of the app - controls the creation of view controllers and the presentation of those controllers onto the view hierarchy
protocol AchievementsWireframe: class {
    static func createAchievementsModule(session: STSession, requestBuilder: RequestBuilder) -> UIViewController

    func presentAchievementInfo(in viewController: AchievementsView, animated: Bool)
    func presentAchievementDetail(achievement: Achievement, in viewController: AchievementsView, animated: Bool)
}

final class AchievementsWireframeImplementation: AchievementsWireframe {
    
    // MARK: - AchievementsWireframe
    static func createAchievementsModule(session: STSession, requestBuilder: RequestBuilder) -> UIViewController {
        
        let viewController = AchievementsViewController()
        
        let interactor = AchievementsInteractorImplementation(session: session, requestBuilder: requestBuilder)
        
        let wireframe = AchievementsWireframeImplementation()
        
        let presenter = AchievementsPresenter(view: viewController, interactor: interactor, wireframe: wireframe)
        
        viewController.presenter = presenter
        
        let navigationController = AchievementsNavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    func presentAchievementInfo(in viewController: AchievementsView, animated: Bool) {
        guard let viewController = viewController as? UIViewController else {
            return
        }
        let title = NSLocalizedString("Feature Unavailable", comment: "A title for an unavailable feature")
        let body = NSLocalizedString("This feature is unavailable in this version of StashCoach", comment: "An explaination that a feature is unavailble in the current version of the app")
        
        let deadEndViewController = UnfinishedFeatureViewController(reasonTitle: title, body: body)
        
        if let navController = viewController.navigationController {
            navController.pushViewController(deadEndViewController, animated: animated)
        }
        else {
            viewController.present(deadEndViewController, animated: animated, completion: nil)
        }
    }
    
    func presentAchievementDetail(achievement: Achievement, in viewController: AchievementsView, animated: Bool) {
        guard let viewController = viewController as? UIViewController else {
            return
        }
        let title = NSLocalizedString("Feature Unavailable", comment: "A title for an unavailable feature")
        let body = NSLocalizedString("This feature is unavailable in this version of StashCoach", comment: "An explaination that a feature is unavailble in the current version of the app")
        
        let deadEndViewController = UnfinishedFeatureViewController(reasonTitle: title, body: body)
        
        if let navController = viewController.navigationController {
            navController.pushViewController(deadEndViewController, animated: animated)
        }
        else {
            viewController.present(deadEndViewController, animated: animated, completion: nil)
        }
    }
}
