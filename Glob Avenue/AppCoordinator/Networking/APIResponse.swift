//
//  APIResponse.swift
//  Glob Avenue
//
//  Created by Imran Malik on 03/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

public struct APIResponse<T: Codable>: GlobCodable {
    public let data: T
    private let status: Int?
    public let msg: String?

//    public init(data: T, msg: String, status: Int) {
//        self.data = data
//        self.msg = msg
//        self.status = status
//    }
}
