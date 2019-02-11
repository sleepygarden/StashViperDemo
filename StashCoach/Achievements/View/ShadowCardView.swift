//
//  ShadowCardView.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/7/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit

/// ShadowCardView - AchievementTableViewCell component
final class ShadowCardView: UIView {

    let containerView: UIView
    
    struct Constants {
        static let shadowDirection = CGSize(width: 0, height: 2)
        static let shadowColor = UIColor.black
        static let shadowRadius: CGFloat = 3.0
        static let shadowOpacity: Float = 0.3
        
        static let cornerRadius: CGFloat = 16.0
    }
    
    init() {
        containerView = UIView(frame: .zero)
        
        super.init(frame: .zero)
    
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        layer.shadowRadius = Constants.shadowRadius
        layer.shadowOffset = Constants.shadowDirection
        layer.shadowColor = Constants.shadowColor.cgColor
        layer.shadowOpacity = Constants.shadowOpacity
        
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.layer.masksToBounds = true
        
        addSubview(containerView)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
