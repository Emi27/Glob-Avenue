//
//  User.swift
//  Glob Avenue
//
//  Created by Imran Malik on 29/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

public struct User: Hashable, GlobCodable {    
    public let id: Int
    public let role: String
    public let email: String

}

