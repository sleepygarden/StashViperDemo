//
//  Achievement.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import Foundation

/// Achievement - models a goal a user can accomplish in Coach
struct Achievement {
    
    struct Keys {
        static let id = "id"
        static let level = "level"
        static let progress = "progress"
        static let total = "total"
        static let bgImageURL = "bg_image_url"
        static let accessible = "accessible"
    }
    
    let id: String
    let level: String
    let progress: Int
    let total: Int
    let bgImageURL: URL?
    let accessible: Bool
    
    init(id: String, level: String, progress: Int, total: Int, bgImageURLString: String?, accessible: Bool) {
        self.id = id
        self.level = level
        self.progress = progress
        self.total = total
        if let bgImageURLString = bgImageURLString {
            self.bgImageURL = URL(string: bgImageURLString)
        }
        else {
            self.bgImageURL = nil
        }
        self.accessible = accessible
    }
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary[Keys.id] as? Int,
            let level = dictionary[Keys.level] as? String,
            let progress = dictionary[Keys.progress] as? Int,
            let total = dictionary[Keys.total] as? Int,
            let bgImageURLString = dictionary[Keys.bgImageURL] as? String,
            let accessible = dictionary[Keys.accessible] as? Bool else {
                return nil
        }
        self.init(id: "\(id)", level: level, progress: progress, total: total, bgImageURLString: bgImageURLString, accessible: accessible)
    }
}
