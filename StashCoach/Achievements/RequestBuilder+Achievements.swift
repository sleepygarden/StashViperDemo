//
//  RequestBuilder+Achievements.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

/// Requests for the Achievements feature
extension RequestBuilder {
    
    func allAchievements() -> URLRequest {
        return get("achievements.json")
    }
}
