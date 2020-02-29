//
//  Navigation+Extenstions.swift
//  Glob Avenue
//
//  Created by Imran Malik on 24/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var shouldAutorotate: Bool { return true }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let currentController = self.topViewController {
            return currentController.navigationSupportedInterfaceOrientations
        } else {
            return [.portrait]
        }
    }

    func setLightAppearance() {
        navigationBar.setLightAppearance()
    }

    func setDarkAppearance(darkColor: UIColor = .black) {
        navigationBar.setDarkAppearance(darkColor: darkColor)
    }
}

extension UINavigationBar {
    
    func setLightAppearance() {
        backgroundColor = .white
        shadowImage = UIImage()
        titleTextAttributes = [
            .foregroundColor: UIColor.darkText,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        barStyle = .default
        isOpaque = true
        isTranslucent = true
        tintColor = .darkText
        barTintColor = .white
    }

    fileprivate func setDarkAppearance(darkColor: UIColor = .black) {
        backgroundColor = darkColor
        shadowImage = UIImage()
        titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        barStyle = .black
        isOpaque = true
        isTranslucent = false
        tintColor = .white
        barTintColor = darkColor
    }
}



extension UIViewController {
    @objc
    open var navigationSupportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
}

