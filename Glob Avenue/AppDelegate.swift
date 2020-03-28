//
//  AppDelegate.swift
//  Globe Avenue
//
//  Created by Imran Malik on 15/02/20.
//  Copyright © 2020 Era. All rights reserved.
//
// Yellow color code - B49309
import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD

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
        setProgressStyle()
        return true
    }

    private func setProgressStyle() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setDefaultAnimationType(.native)
    }
    
}

