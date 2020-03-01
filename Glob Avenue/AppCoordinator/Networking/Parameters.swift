//
//  Parameters.swift
//  Glob Avenue
//
//  Created by Imran Malik on 29/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import Foundation

public protocol ParameterConvertible {
    func asParameterData() throws -> Data
    var value: [String: Any] { get }
}

public protocol GlobCodable: Codable, ParameterConvertible {

}

public extension GlobCodable {
    func asParameterData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(self)
        return data
    }

    var value: [String : Any] {
        return [:]
    }
}

public class ParamDictionary: ParameterConvertible, ExpressibleByDictionaryLiteral {
    public typealias Key = String
    public typealias Value = Any

    public var value: [String: Any] = [:]

    required public init(dictionaryLiteral elements: (String, Any)...) {
        self.value = elements.reduce(into: [String: Any]()) { res, next in
            res[next.0] = next.1
        }
    }

    public init(_ value: [String: Any]) {
        self.value = value
    }

    public func asParameterData() throws -> Data {
        let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
        return data
    }
}
