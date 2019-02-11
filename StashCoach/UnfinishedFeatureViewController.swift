//
//  UnfinishedFeatureViewController.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/10/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit


/// UnfinishedFeatureViewController - a view controller to present for dead ends in the demo app
final class UnfinishedFeatureViewController: UIViewController {
    
    let reasonTitle: String
    let reasonBody: String
    init(reasonTitle: String, body: String) {
        self.reasonTitle = reasonTitle
        self.reasonBody = body
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white

        title = self.reasonTitle
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let infoViewController = UIAlertController(title: reasonTitle, message: reasonBody, preferredStyle: .alert)
        let confirmTitle = NSLocalizedString("OK", comment: "A word indicating confirmation")
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { (_) in }
        infoViewController.addAction(confirmAction)
        
        present(infoViewController, animated: animated, completion: nil)
    }
}

