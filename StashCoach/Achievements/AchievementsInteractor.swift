//
//  AchievementsInteractor.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/6/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

/// AchievementsInteractor - an Achievements module interactor for getting / posting info to outside APIs
protocol AchievementsInteractor: class {
    func retrieveAchievements()
    var  outputDelegate: AchievementsInteractorDelegate? { get set }
}

protocol AchievementsInteractorDelegate: class {
    func interactorDidRetrieveAchievements(title: String, achievements: [Achievement])
    func interactorFailedToRetrieveAchievements(error: Error)
}

final class AchievementsInteractorImplementation: AchievementsInteractor {
    
    weak var outputDelegate: AchievementsInteractorDelegate? = nil
    
    let session: STSession
    let requestBuilder: RequestBuilder
    
    init(session: STSession, requestBuilder: RequestBuilder) {
        self.session = session
        self.requestBuilder = requestBuilder
    }
    
    func retrieveAchievements() {
        session.makeRequest(requestBuilder.allAchievements(), responseProcessor: AchievementsResponseProcessor({ [weak self] (achievementsOrError) in
            switch achievementsOrError {
                case .error(let error):
                    self?.outputDelegate?.interactorFailedToRetrieveAchievements(error: error)
                case .value(let response):
                    self?.outputDelegate?.interactorDidRetrieveAchievements(title: response.title, achievements: response.achievements)
            }
        }))
    }
}
