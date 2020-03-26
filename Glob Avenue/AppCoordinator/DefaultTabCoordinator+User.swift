//
//  NetworkLayer+User.swift
//  Glob Avenue
//
//  Created by Imran Malik on 25/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

private let currentUserKey = "com.globaVenue.app.current-user-key"
private let userChangedNotificationName = "com.globaVenue.app.user.user-changed"

extension DefaultTabCoordinator {
    var currentUser: User? {
        get {
            guard let data = UserDefaults.standard.data(forKey: currentUserKey) else { return nil }
            return try? User.decode(data: data)
        }
        set {
            let oldUser = currentUser
            storeUser(newValue)
            if shouldPostNotification(for: oldUser, newUser: newValue) {
                NotificationCenter.default.post(.userChanged)
            }
        }
    }

    private func storeUser(_ user: User?) {
        if let user = user {
            let data = try? JSONEncoder().encode(user)
            UserDefaults.standard.setValue(data, forKey: currentUserKey)
        } else {
            UserDefaults.standard.setValue(nil, forKey: currentUserKey)
        }
    }

    private func shouldPostNotification(for oldUser: User?, newUser: User?) -> Bool {
        switch (oldUser, newUser) {
        case (.some(let user1), .some(let user2)): return user1 != user2
        case (.none, .none): return false
        default: return true
        }
    }
}

public extension Notification.Name {
    static let userChanged = Notification.Name(userChangedNotificationName)
}

public extension Notification {
    static let userChanged = Notification(name: .userChanged)
}
