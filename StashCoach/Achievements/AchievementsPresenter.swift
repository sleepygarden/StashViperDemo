//
//  AchievementsPresenter.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/6/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

/// AchievementsPresenter - a presenter to wire together the functionality of the Achievements module's pieces. retains all the module pieces except the view
final class AchievementsPresenter: AchievementsInteractorDelegate {
    
    //MARK: - AchievementPresenter

    weak var view: AchievementsView?
    let interactor: AchievementsInteractor
    let wireframe: AchievementsWireframe
    
    init(view: AchievementsView, interactor: AchievementsInteractor, wireframe: AchievementsWireframe) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe

        self.interactor.outputDelegate = self
    }
    
    func updateView() {
        view?.showAwaitingContent(animated: true)
        interactor.retrieveAchievements()
    }
    
    func displayMoreInfo() {
        guard let view = view else {
            return
        }
        wireframe.presentAchievementInfo(in: view, animated: true)
    }
    
    func displayAchievementDetail(_ achievement: Achievement) {
        guard let view = view else {
            return
        }
        wireframe.presentAchievementDetail(achievement: achievement, in: view, animated: true)
    }
    
    //MARK: - AchievementsInteractorDelegate
    
    func interactorDidRetrieveAchievements(title: String, achievements: [Achievement]) {
        view?.showAchievements(achievements, title: title, animated: true)
    }
    
    func interactorFailedToRetrieveAchievements(error: Error) {
        view?.showNoContent(animated: true)
    }
}
