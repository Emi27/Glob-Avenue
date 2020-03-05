//
//  User.swift
//  Glob Avenue
//
//  Created by Imran Malik on 29/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

public struct User: Hashable, GlobCodable {    
    public let _id: String
    public let role: String
    public let email: String
    public let username: String

    init(role: String, _id: String, email: String, username: String) {
        self.role = role
        self._id = _id
        self.email = email
        self.username = username
    }
}

