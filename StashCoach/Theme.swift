//
//  Theme.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/7/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit

/// Colors - app colors
struct Colors {
    static let darkTextColor = UIColor(white: 0.15, alpha: 1)
    static let offWhite = UIColor(white: 0.94, alpha: 1)
    static let progressGreen = UIColor(red: 0.44, green: 0.79, blue: 0.36, alpha: 1)
    static let navigationPurple = UIColor(red: 0.41, green: 0.21, blue: 0.80, alpha: 1)
}

/// Fonts - app fonts
struct Fonts {
    private static func font(named name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            fatalError("The developer didn't provide a valid font name")
        }
        return font
    }
    
    static func helveticaNeue(_ size: CGFloat) -> UIFont {
        return font(named: "HelveticaNeue", size: size)
    }
    
    static func helveticaNeueBold(_ size: CGFloat) -> UIFont {
        return font(named: "HelveticaNeue-Bold", size: size)
    }
}
