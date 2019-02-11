//
//  AchievementsResponseProcessor.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

enum AchievementsResponseProcessorError: Error {
    case invalidData
}

/// AchievementsResponseProcessor - a ResponseProcessor for parsing the Achievements endpoint response
struct AchievementsResponseProcessor: ResponseProcessor {
    
    struct Keys {
        static let achievements = "achievements"
        static let overview = "overview"
        static let title = "title"
    }
    
    private let completion: (APIResponse<(title: String, achievements: [Achievement])>) -> ()
    
    init(_ completion: @escaping (APIResponse<(title: String, achievements: [Achievement])>) -> ()) {
        self.completion = completion
    }
    
    func processResponse(_ response: APIResponse<[String: Any]>) {
        switch response {
        case .error(let error):
            completion(.error(error))
        case .value(let json):
            guard let rawAchievementsArray = json[Keys.achievements] as? [[String: Any]] else {
                completion(.error(AchievementsResponseProcessorError.invalidData))
                return
            }
            
            guard let overviewDict = json[Keys.overview] as? [String: Any], let titleString = overviewDict[Keys.title] as? String else {
                completion(.error(AchievementsResponseProcessorError.invalidData))
                return
            }
            let achievements = rawAchievementsArray.compactMap(Achievement.init)
            let parsedValue = (title: titleString, achievements: achievements)
            completion(.value(parsedValue))
        }
    }
}
