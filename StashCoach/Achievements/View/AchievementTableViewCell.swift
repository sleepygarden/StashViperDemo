//
//  AchievementTableViewCell.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/6/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit
import SDWebImage

/// AchievementTableViewCell - displays details about an Achievement
final class AchievementTableViewCell: UITableViewCell {
    
    struct Constants {        
        static let cardMargin = UIEdgeInsets(top: 0, left: 24.0, bottom: 16.0, right: 24.0)
        static let cardPadding = UIEdgeInsets(top: 24.0, left: 16.0, bottom: 24.0, right: 16.0)
        
        static let circleWidthRadius: CGFloat = 56.0
        
        static let circleBackgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        static let progressBarHeight: CGFloat = 12.0
        static let progressBarTopMargin: CGFloat = 24.0
        
        static let progressBackgroundColor = Colors.offWhite
        static let progressForegroundColor = Colors.progressGreen
        
        static let pointsLabelTopMargin: CGFloat = 16.0
        static let pointsLabelHeight: CGFloat = 21.0
        static let pointsSuffixText = NSLocalizedString("pts", comment: "A shortend word for points trailing a number, ex: 10 pts")
        static let pointsLabelFont = Fonts.helveticaNeueBold(18) // and this jumps into serif for one the 1 digit in achievement 1
        static let pointsLabelTextColor = UIColor.white
        
    }
    
    static var defaultReuseIdentifier: String = {
        return String(describing: self)
    }()
    
    static func height() -> CGFloat {
        return Constants.cardMargin.top + Constants.cardPadding.top +
            (Constants.circleWidthRadius * 2) +
            Constants.progressBarTopMargin + Constants.progressBarHeight +
            Constants.pointsLabelTopMargin + Constants.pointsLabelHeight +
            Constants.cardPadding.bottom + Constants.cardMargin.bottom
    }
    
    private let roundedContainerView = ShadowCardView()
    
    private let imageBackgroundView = UIImageView(frame: .zero)
    
    private let circleLevelLabel = CenteredCircleLevelLabel()
    
    private let progressBar = ProgressBarView(barColor: Constants.progressForegroundColor)
    
    private let currentPointsLabel = UILabel(frame: .zero)
    private let totalPointsLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        // depending on scroll performance requirements, I might switch this to layoutSubviews and just do the frames manually, but constraints are easier to read and write
        setupBackgroundView()
        setupCenterCircle()
        setupProgressBar()
        setupPointsLabels()        
    }
    
    func setupBackgroundView() {
        roundedContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(roundedContainerView)
        
        imageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        imageBackgroundView.contentMode = .scaleAspectFill
        
        roundedContainerView.containerView.addSubview(imageBackgroundView)
        
        NSLayoutConstraint.activate([
            roundedContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.cardMargin.left),
            roundedContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.cardMargin.left),
            roundedContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.cardMargin.top),
            roundedContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.cardMargin.bottom),
            
            imageBackgroundView.widthAnchor.constraint(equalTo: roundedContainerView.widthAnchor),
            imageBackgroundView.heightAnchor.constraint(equalTo: roundedContainerView.heightAnchor)
            ])
    }
    
    
    func setupCenterCircle() {
        circleLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        circleLevelLabel.backgroundColor = Constants.circleBackgroundColor
        
        roundedContainerView.containerView.addSubview(circleLevelLabel)
        
        NSLayoutConstraint.activate([
            circleLevelLabel.widthAnchor.constraint(equalToConstant: Constants.circleWidthRadius * 2),
            circleLevelLabel.heightAnchor.constraint(equalTo: circleLevelLabel.widthAnchor),
            circleLevelLabel.centerXAnchor.constraint(equalTo: roundedContainerView.centerXAnchor),
            circleLevelLabel.topAnchor.constraint(equalTo: roundedContainerView.topAnchor, constant: Constants.cardPadding.top)
            ])
    }
    
    func setupProgressBar() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.backgroundColor = Constants.progressBackgroundColor
        
        roundedContainerView.containerView.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            progressBar.leftAnchor.constraint(equalTo: roundedContainerView.leftAnchor, constant: Constants.cardPadding.left),
            progressBar.rightAnchor.constraint(equalTo: roundedContainerView.rightAnchor, constant: -Constants.cardPadding.right),
            progressBar.topAnchor.constraint(equalTo: circleLevelLabel.bottomAnchor, constant: Constants.progressBarTopMargin),
            progressBar.heightAnchor.constraint(equalToConstant: Constants.progressBarHeight)
            ])
    }
    
    func setupPointsLabels() {
        currentPointsLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPointsLabel.font = Constants.pointsLabelFont
        currentPointsLabel.textColor = Constants.pointsLabelTextColor
        currentPointsLabel.textAlignment = .left
        
        roundedContainerView.containerView.addSubview(currentPointsLabel)
        
        totalPointsLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPointsLabel.font = Constants.pointsLabelFont
        totalPointsLabel.textColor = Constants.pointsLabelTextColor
        totalPointsLabel.textAlignment = .right
        
        roundedContainerView.containerView.addSubview(totalPointsLabel)
        
        NSLayoutConstraint.activate([
            currentPointsLabel.leftAnchor.constraint(equalTo: roundedContainerView.leftAnchor, constant: Constants.cardPadding.left),
            totalPointsLabel.rightAnchor.constraint(equalTo: roundedContainerView.rightAnchor, constant: -Constants.cardPadding.right),
            currentPointsLabel.heightAnchor.constraint(equalToConstant: Constants.pointsLabelHeight),
            totalPointsLabel.heightAnchor.constraint(equalToConstant: Constants.pointsLabelHeight),
            
            currentPointsLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: Constants.pointsLabelTopMargin),
            totalPointsLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: Constants.pointsLabelTopMargin)
            ])
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(level: String, achievementPointsProgress: Int, totalPoints: Int, imageURL: URL?, placeholderColorIndex: Int) {
        // mcornell - 2/10/19 - in the demo app, just use a rainbow as a placeholder image. In prod, use something from design.
        
        // Another real concern is, should we be blocking the interactor completion until all images are downloaded, or loading them async like this? I vote async, these images are fairly small and not user generated - very easy to cache and persist. its better to give the users access to their achievements sooner rather than later, especially if they have a spotty enough network that would adversely affect loading these smaller images.
        
        let rainbowColor = UIColor(hue: CGFloat(placeholderColorIndex) * 0.08, saturation: 0.9, brightness: 0.8, alpha: 1)
        let pixelColorImage = UIColor.pixel(from: rainbowColor)
        
        if let imageURL = imageURL {
            imageBackgroundView.sd_setImage(with: imageURL, placeholderImage: pixelColorImage, options: [], completed: nil)
        }
        else {
            imageBackgroundView.image = pixelColorImage
        }
    
        circleLevelLabel.update(level: level)
        
        progressBar.progress = CGFloat(achievementPointsProgress) / CGFloat(totalPoints)
        
        currentPointsLabel.text = "\(achievementPointsProgress)\(Constants.pointsSuffixText)"
        totalPointsLabel.text = "\(totalPoints)\(Constants.pointsSuffixText)"
    }
}
