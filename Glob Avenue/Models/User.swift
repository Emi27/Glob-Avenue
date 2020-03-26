//
//  User.swift
//  Glob Avenue
//
//  Created by Imran Malik on 29/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

public struct User: Hashable, GlobCodable {    
    public var _id: String?
    public var role: String?
    public var email: String?
    public var username: String?
    public var user_type: Bool?
    public var status: Bool?
    public var address: String?
    public var phone: String?
    public var password: String?
    public var location: String?
    public var zip_code: String?
    public var contact_name: String?
    public var created_at: String?
    public var __v: Int?
    public var login_time: String?
    public var country: String?
    public var language: String?
    public var profile_image: String?
    public var updated_at: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Bool.self, forKey: .status)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.status, forKey: .status)
    }
}
