//
//  NetworkProtocol.swift
//  Glob Avenue
//
//  Created by Imran Malik on 27/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import Foundation
import Alamofire

public typealias Completion<T> = ((Result<T, GlobError>) -> Void)
public typealias ReqMethod = HTTPMethod

protocol NetworkProtocol {
    func request<T: Decodable>(containerType: T.Type, method: ReqMethod, values: ParameterConvertible?, path: String, completion: @escaping Completion<APIResponse<T>>)
    func request<T: Decodable>(containerType: T.Type, values: ParameterConvertible?, path: String, method: ReqMethod, completion: @escaping Completion<T>)
}
