//
//  AchievementsViewController.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/6/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit

/// AchievementsView - a view for the Achievements module
protocol AchievementsView: class {
    var presenter: AchievementsPresenter? { get set }
    func showAchievements(_ achievements: [Achievement], title: String, animated: Bool)
    func showAwaitingContent(animated: Bool)
    func showNoContent(animated: Bool)
}

final class AchievementsViewController: UIViewController, AchievementsView, UITableViewDataSource, UITableViewDelegate {
    
    struct Constants {
        static let tableInset = UIEdgeInsets(top: 24.0, left: 0, bottom: 0, right: 0)
        static let activityIndicatorTopPadding: CGFloat = 84.0
        
        static let animationTransitionSpeed: TimeInterval = 0.130
    }
    private var achievements: [Achievement] = []
    
    private let workingSpinner = UIActivityIndicatorView(style: .whiteLarge)
    private let achievementsTableView = UITableView(frame: .zero)
    private let workingWrapperView = UIView(frame: .zero)
    private let noContentView = UIView(frame: .zero)
    
    var presenter: AchievementsPresenter? = nil
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        workingWrapperView.frame = view.frame
        workingWrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        workingWrapperView.addSubview(workingSpinner)
        workingWrapperView.backgroundColor = .white
        
        workingSpinner.translatesAutoresizingMaskIntoConstraints = false
        workingSpinner.hidesWhenStopped = false
        workingSpinner.color = Colors.darkTextColor
        
        NSLayoutConstraint.activate([
            workingSpinner.topAnchor.constraint(equalTo: workingWrapperView.topAnchor, constant: Constants.activityIndicatorTopPadding),
            workingSpinner.centerXAnchor.constraint(equalTo: workingWrapperView.centerXAnchor)
            ])
        
        achievementsTableView.frame = view.frame
        achievementsTableView.backgroundColor = .white
        achievementsTableView.separatorColor = .clear
        achievementsTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        achievementsTableView.dataSource = self
        achievementsTableView.delegate = self
        achievementsTableView.tableFooterView = UIView() // trims trailing cells
        achievementsTableView.contentInset = Constants.tableInset
        
        noContentView.frame = view.frame
        noContentView.backgroundColor = .white
        noContentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let noContentLabel = UILabel(frame: .zero)
        noContentLabel.textColor = Colors.darkTextColor
        noContentLabel.font = Fonts.helveticaNeue(18)
        noContentLabel.textAlignment = .center
        noContentLabel.text = NSLocalizedString("We couldn't get any achievements! Please try again.", comment: "A message to tell a user that an operation to fetch their achievements failed.")
        noContentLabel.numberOfLines = 0
        noContentLabel.translatesAutoresizingMaskIntoConstraints = false
        noContentView.addSubview(noContentLabel)
        
        NSLayoutConstraint.activate([
            noContentLabel.centerXAnchor.constraint(equalTo: noContentView.centerXAnchor),
            noContentLabel.centerYAnchor.constraint(equalTo: noContentView.centerYAnchor),
            noContentLabel.widthAnchor.constraint(equalTo: noContentView.widthAnchor)
            ])
        
        view.addSubview(achievementsTableView)
        
        let moreInfoButton = UIButton(type: .infoLight) // TODO change to final asset
        moreInfoButton.addTarget(self, action: #selector(moreInfoTapped), for: .touchUpInside)
        let statusBarItem = UIBarButtonItem(customView: moreInfoButton)
        navigationItem.rightBarButtonItem = statusBarItem
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // reloads the view each time it appears - tbd is that is desired functionality
        presenter?.updateView()
    }
    
    func showAchievements(_ achievements: [Achievement], title: String, animated: Bool) {
        self.achievements = achievements
        achievementsTableView.reloadData()
        
        self.title = title
        
        
        self.workingSpinner.stopAnimating()
        
        if animated {
            self.workingWrapperView.layer.removeAllAnimations()
            UIView.animate(withDuration: Constants.animationTransitionSpeed, delay: 0, options: [.curveEaseIn, .beginFromCurrentState], animations: { [weak self] in
                self?.workingWrapperView.alpha = 0
                }, completion: { [weak self] (_) in
                    self?.workingWrapperView.isHidden = true
                    self?.workingWrapperView.removeFromSuperview()
            })
        }
        else {
            self.workingWrapperView.isHidden = true
        }
    }
    
    func showAwaitingContent(animated: Bool) {
        workingWrapperView.alpha = 0
        workingWrapperView.isHidden = false
        workingSpinner.startAnimating()
        
        view.addSubview(workingWrapperView)
        
        if animated {
            workingWrapperView.layer.removeAllAnimations()
            UIView.animate(withDuration: Constants.animationTransitionSpeed, delay: 0, options: [.curveEaseIn, .beginFromCurrentState], animations: { [weak self] in
                self?.workingWrapperView.alpha = 1
                }, completion: nil)
        }
        else {
            self.workingWrapperView.alpha = 1
        }
    }
    
    func showNoContent(animated: Bool) {
        noContentView.alpha = 0
        noContentView.isHidden = false
        
        view.addSubview(noContentView)
        
        if animated {
            noContentView.layer.removeAllAnimations()
            UIView.animate(withDuration: Constants.animationTransitionSpeed, delay: 0, options: [.curveEaseIn, .beginFromCurrentState], animations: { [weak self] in
                self?.noContentView.alpha = 1
                }, completion: nil)
        }
        else {
            noContentView.alpha = 1
        }
    }
    
    @objc private func moreInfoTapped() {
        presenter?.displayMoreInfo()
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AchievementTableViewCell.defaultReuseIdentifier) as? AchievementTableViewCell ?? AchievementTableViewCell(style: .default, reuseIdentifier: AchievementTableViewCell.defaultReuseIdentifier)
        
        guard let achievement = achievement(at: indexPath.row) else {
            assertionFailure("Achievement not found at index \(indexPath.row) among \(achievements.count)")
            return cell
        }
        cell.update(level: achievement.level, achievementPointsProgress: achievement.progress, totalPoints: achievement.total, imageURL: achievement.bgImageURL, placeholderColorIndex: indexPath.row)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AchievementTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let achievement = achievement(at: indexPath.row) else {
            assertionFailure("Achievement not found at index \(indexPath.row) among \(achievements.count)")
            return
        }
        presenter?.displayAchievementDetail(achievement)
    }
    
    //MARK: - Private
    
    private func achievement(at index: Int) -> Achievement? {
        if index >= 0 && index < achievements.count {
            return achievements[index]
        }
        return nil
    }
}
