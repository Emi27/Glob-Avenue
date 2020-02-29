//
//  AppDelegate.swift
//  Globe Avenue
//
//  Created by Imran Malik on 15/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var appCoordinator = DefaultTabCoordinator()

    private var initialController: UIViewController? {
        return appCoordinator.initialController
    }

    lazy var window: UIWindow? = {
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        newWindow.rootViewController = initialController
        return newWindow
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        window?.makeKeyAndVisible()
        return true
    }

}

