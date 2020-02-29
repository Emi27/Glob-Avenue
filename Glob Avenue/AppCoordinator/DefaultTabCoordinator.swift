//
//  DefaultTabCoordinator.swift
//  Glob Avenue
//
//  Created by Imran Malik on 24/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

class DefaultTabCoordinator: UITabBarController, MainSectionCoordinator {

    var initialController: UIViewController? {
        return self
    }

    var currentNavController: AppNavigator?
    let api: NetworkLayer
    
    init(api: NetworkLayer = NetworkLayer()) {
        self.api = api
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showLogin()
    }
}

extension DefaultTabCoordinator {

    func dismissController() {
        self.currentNavController?.dismiss(animated: true, completion: nil)
    }

    func displayContent(_ controller: UIViewController,
                        hideTabBar: Bool? = nil,
                        animated: Bool = true,
                        hideNavBar: Bool = false) {
        if let hidesBar = hideTabBar {
            controller.hidesBottomBarWhenPushed = hidesBar
        }
        DispatchQueue.main.async {
            self.currentNavController?.pushViewController(controller, animated: animated)
            self.currentNavController?.setNavigationBarHidden(hideNavBar, animated: animated)
        }
    }

    func present(controller: UIViewController, animated: Bool, embeddInNav: Bool = false, fullScreen: Bool = false) {
        var controller = controller

        if embeddInNav {
            controller = embedInNavigation(controller: controller)
        }

        if fullScreen {
            controller.modalPresentationStyle = .fullScreen
        }

        if let presented = presentedViewController {
            presented.present(controller, animated: animated, completion: nil)
        } else {
            present(controller, animated: animated, completion: nil)
        }
    }

    func embedInNavigation(controller: UIViewController) -> AppNavigator {
        let navigation = AppNavigator(rootViewController: controller)
        currentNavController = navigation
        navigation.setLightAppearance()
        return navigation
    }
}
