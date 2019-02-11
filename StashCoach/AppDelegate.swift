//
//  AppDelegate.swift
//  StashCoach
//
//  Created by Michael Cornell on 2/5/19.
//  Copyright © 2019 Michael Cornell. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        // don't spin up the app + shared state for unit tests
        if NSClassFromString("XCTest") != nil {
            return true
        }
        #endif
        
        let networkSession = FileSession()
        let requestBuilder = RequestBuilder(root: "https://www.sleepy.nyc")
        let rootViewController = AchievementsWireframeImplementation.createAchievementsModule(session: networkSession, requestBuilder: requestBuilder)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}

