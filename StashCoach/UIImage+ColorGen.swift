//
//  UIImage+ColorGen.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/10/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func pixel(from color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
