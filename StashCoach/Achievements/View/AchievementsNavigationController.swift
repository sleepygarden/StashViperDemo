//
//  AchievementsNavigationController.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/7/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit

/// AchievementsNavigationController - a styled navigation controller for the Achievements module
final class AchievementsNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = Colors.navigationPurple
        navigationBar.titleTextAttributes = [
            .font: Fonts.helveticaNeue(14),
            .foregroundColor: UIColor.white
        ]
        navigationBar.tintColor = UIColor.white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

