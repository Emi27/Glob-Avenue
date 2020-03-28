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

    var defaultTabController: DefaultTabCoordinator? {
        return self
    }

    var currentNavController: AppNavigator?
    let api: NetworkLayer

    var isLoggedIn: Bool {
        return currentUser != nil
    }

    // MARK: Home
    private lazy var homeNavController: AppNavigator = {
        let nav = AppNavigator(rootViewController: homeViewController)
        nav.setLightAppearance()
        return nav
    }()

    private lazy var homeViewModel = HomeViewModel(coordinator: self)

    private lazy var homeViewController: HomeViewController = {
        let controller = HomeViewController(viewModel: homeViewModel)
        controller.tabBarItem = TabIcon.home
        return controller
    }()

    
    // MARK: Favourite
    private lazy var favNavController: AppNavigator = {
        let nav = AppNavigator(rootViewController: favViewController)
        nav.setLightAppearance()
        return nav
    }()

    private lazy var favViewModel = FavouritesViewModel(coordinator: self)

    private lazy var favViewController: FavouritesViewController = {
        let controller = FavouritesViewController(viewModel: favViewModel)
        controller.tabBarItem = TabIcon.favourites
        return controller
    }()

    
    // MARK: Post Ads
    private lazy var postAdNavController: AppNavigator = {
        let nav = AppNavigator(rootViewController: postAdViewController)
        nav.setLightAppearance()
        return nav
    }()

    private lazy var postAdViewModel = PostAdViewModel(coordinator: self)

    private lazy var postAdViewController: PostAdViewController = {
        let controller = PostAdViewController(viewModel: postAdViewModel)
        controller.tabBarItem = TabIcon.postAd
        return controller
    }()
    
    // MARK: Chats
    private lazy var chatsNavController: AppNavigator = {
        let nav = AppNavigator(rootViewController: chatsViewController)
        nav.setLightAppearance()
        return nav
    }()

    private lazy var chatsViewModel = ChatsViewModel(coordinator: self)

    private lazy var chatsViewController: ChatsViewController = {
        let controller = ChatsViewController(viewModel: chatsViewModel)
        controller.tabBarItem = TabIcon.chats
        return controller
    }()
    

    // MARK: Profile
    private lazy var profileNavController: AppNavigator = {
        let nav = AppNavigator(rootViewController: profileViewController)
        nav.setLightAppearance()
        return nav
    }()

    private lazy var profileViewModel = ProfileViewModel(coordinator: self)

    private lazy var profileViewController: ProfileViewController = {
        let controller = ProfileViewController(viewModel: profileViewModel)
        controller.tabBarItem = TabIcon.profile
        return controller
    }()
  
    lazy var navControllers = [homeNavController, favNavController, postAdNavController,
                               chatsNavController, profileNavController]

    // MARK: - Initializer and view life cycle
    init(api: NetworkLayer = NetworkLayer()) {
        self.api = api
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setViewControllers(navControllers, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        if !isLoggedIn { showLogin() }
    }

    func store(user: User) {
        self.currentUser = user
    }

    func deleteCurrentUser() {
        self.currentUser = nil
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
