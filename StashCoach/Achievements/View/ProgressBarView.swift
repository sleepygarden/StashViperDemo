//
//  ProgressBarView.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/7/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit

/// ProgressBarView - AchievementTableViewCell component
final class ProgressBarView: UIView {
    
    private let foregroundBar = UIView(frame: .zero)
    var progress: CGFloat = 0 {
        didSet {
            relayoutProgressBar()
        }
    }
    
    private lazy var progressWidthConstraint: NSLayoutConstraint = {
        return foregroundBar.widthAnchor.constraint(equalToConstant: 0)
    }()
    
    init(barColor: UIColor) {
        super.init(frame: .zero)
        
        foregroundBar.backgroundColor = barColor
        layer.masksToBounds = true
        addSubview(foregroundBar)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
        foregroundBar.layer.cornerRadius = frame.size.height / 2
        relayoutProgressBar()
    }
    
    private func relayoutProgressBar() {
        let clippedProgress = max(min(progress, 1), 0)
        foregroundBar.frame = CGRect(x: 0, y: 0, width: clippedProgress * frame.size.width, height: frame.size.height)
    }
}
