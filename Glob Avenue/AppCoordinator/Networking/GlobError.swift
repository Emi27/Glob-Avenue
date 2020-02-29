//
//  GlobError.swift
//  Glob Avenue
//
//  Created by Imran Malik on 29/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import Foundation
import Alamofire

public struct GlobError: Error, LocalizedError {
    public let errorMessages: [String: String]
    public let categoryMessages: [ErrorCategory: String]

    public let code: Int

    public var localizedDescription: String {
        if hasCategory(.frameSpecific) {
            return "Something went wrong talking to your Device"
        } else {
            return categoryMessages.first?.value ?? errorMessages.first?.value ?? "Something went wrong"
        }
    }

    public func hasCategory(_ errorCategory: ErrorCategory) -> Bool {
        return categoryMessages.keys.contains(errorCategory)
    }

    public func messageFor(errorCategory: ErrorCategory) -> String? {
        return categoryMessages[errorCategory]
    }

    public func messageFor(otherKey key: String) -> String? {
        return errorMessages[key]
    }

    public init(_ message: String?, code: Int = -1) {
        let messageString = message ?? "Something went wrong"
        self.init(category: .general, message: messageString, code: code)
    }

    public init(category: ErrorCategory, message: String, code: Int = -1) {
        self.init(messages: [category.rawValue: message], code: code)
    }

    public init(messages: [String: String], code: Int) {
        self.errorMessages = messages
        self.code = code
        var categoryMessages: [ErrorCategory: String] = [:]
        for (key, value) in messages {
            if let category = ErrorCategory(rawValue: key) {
                categoryMessages[category] = value
            }
        }
        self.categoryMessages = categoryMessages
    }

    public init(response: AFDataResponse<Data>) throws {
        let code = response.response?.statusCode ?? -1
        switch response.result {
        case .success(let data):
            do {
                let decodedMessages = try [String: String].decode(data: data)
                self.init(messages: decodedMessages, code: code)
            } catch {
                throw error
            }
        case .failure(let error):
            throw error
        }
    }

    public static let notImplemented = GlobError(messages: ["errors": "Not implemented yet!"], code: -1)
    public static let noCanvases = GlobError(category: .noCanvases,
                                               message: "There are no Devices that you can do that to.")
    public static let notLoggedIn = GlobError(category: .notLoggedIn,
                                                message: "Please log in to perform that action.")
}

public enum ErrorCategory: String, Decodable {
    case general = "errors"
    case network
    case noCanvases
    case decoding
    case subscription
    case purchase
    case frameSpecific
    case notLoggedIn
}

private let decoder = JSONDecoder()
fileprivate extension Decodable {
    static func decode(data: Data, dateFormatter: DateFormatter? = nil) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}
