//
//  CenteredCircleLevelLabel.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/7/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit

/// CenteredCircleLevelLabel - AchievementTableViewCell component
final class CenteredCircleLevelLabel: UIView {
    
    struct Constants {
        static let circleTextTopPadding: CGFloat = 24.0
        static let circleTextLineSpacing: CGFloat = -8.0
        
        static let levelTitleText = NSLocalizedString("Level", comment: "The title of an achievement's level number")
        static let levelTitleFont = Fonts.helveticaNeue(18)
        static let levelNumberFont = Fonts.helveticaNeueBold(56) // i'm pretty sure the designs use helvetica black, not bold, but it isnt stock on ios so :shrug:
        static let levelTextColor = Colors.darkTextColor
    }
    
    private let titleLabel = UILabel(frame: .zero)
    private let numberLabel = UILabel(frame: .zero)
    
    init() {
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        addSubview(numberLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Constants.levelTitleText
        titleLabel.font = Constants.levelTitleFont
        titleLabel.textColor = Constants.levelTextColor
        titleLabel.textAlignment = .center
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = Constants.levelNumberFont
        numberLabel.textColor = Constants.levelTextColor
        numberLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.circleTextTopPadding),
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.circleTextLineSpacing)
            ])
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2
    }
    
    func update(level: String) {
        numberLabel.text = level
    }
}
