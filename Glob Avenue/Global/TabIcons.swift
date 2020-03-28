//
//  TabIcons.swift
//  Glob Avenue
//
//  Created by Imran Malik on 26/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

struct TabIcon {
    static let home: UITabBarItem = {
        let item = UITabBarItem(title: nil,
                                image: #imageLiteral(resourceName: "home").withRenderingMode(.alwaysOriginal),
                                selectedImage: #imageLiteral(resourceName: "home").withRenderingMode(.alwaysOriginal)).addingInsets()
        return item
    }()

    static let favourites: UITabBarItem = {
        let item = UITabBarItem(title: nil,
                                image: #imageLiteral(resourceName: "favourite").withRenderingMode(.alwaysOriginal),
                                selectedImage: #imageLiteral(resourceName: "favourite").withRenderingMode(.alwaysOriginal)).addingInsets()
        return item
    }()

    static let postAd: UITabBarItem = {
        let item = UITabBarItem(title: nil,
                                image: #imageLiteral(resourceName: "postAd").withRenderingMode(.alwaysOriginal),
                                selectedImage: #imageLiteral(resourceName: "postAd").withRenderingMode(.alwaysOriginal)).addingInsets()
        return item
    }()

    static let chats: UITabBarItem = {
        let item = UITabBarItem(title: nil,
                                image: #imageLiteral(resourceName: "chat").withRenderingMode(.alwaysOriginal),
                                selectedImage: #imageLiteral(resourceName: "chat").withRenderingMode(.alwaysOriginal)).addingInsets()
        return item
    }()

    static let profile: UITabBarItem = {
        let item = UITabBarItem(title: nil,
                                image: #imageLiteral(resourceName: "profile").withRenderingMode(.alwaysOriginal),
                                selectedImage: #imageLiteral(resourceName: "profile").withRenderingMode(.alwaysOriginal)).addingInsets()
        return item
    }()
}

fileprivate
extension UITabBarItem {
    func addingInsets() -> UITabBarItem {
        self.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return self
    }
}
