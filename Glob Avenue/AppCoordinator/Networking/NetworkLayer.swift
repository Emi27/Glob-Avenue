//
//  NetworkLayer.swift
//  Glob Avenue
//
//  Created by Imran Malik on 29/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit
import Alamofire

class NetworkLayer: NetworkProtocol {
    
    let base = "https://globe-admin.herokuapp.com/api/"
    public static var fullDebug = true
    
    lazy private var headers: Alamofire.HTTPHeaders = {
        return ["Content-Type": "application/json"]
    }()
    
    private static var urlConfig: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .never
        config.httpCookieStorage = nil
        config.httpShouldSetCookies = false
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return config
    }()

    private static var backgroundConfig: URLSessionConfiguration = {
        let config = URLSessionConfiguration.background(withIdentifier: "com.globAvenue.BackgroundSession")
        config.httpCookieAcceptPolicy = .never
        config.httpCookieStorage = nil
        config.httpShouldSetCookies = false
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.sharedContainerIdentifier = "group.ShareUpload"
        return config
    }()

    private static let sessionManager: Alamofire.Session = {
        return Alamofire.Session(configuration: NetworkLayer.urlConfig)
    }()

    private static var backgroundManager: Alamofire.Session = {
        var manager = Alamofire.Session(configuration: NetworkLayer.backgroundConfig, startRequestsImmediately: true)
        return manager
    }()

    // MARK: Protocol actions
    func request<T: Decodable>(containerType: T.Type, method: ReqMethod, values: ParameterConvertible?, path: String, completion: @escaping Completion<APIResponse<T>>) {
        let dataRequest = createDataRequest(path: path, method: method, value: values)
        dataRequest?.responseData { dataResponse in
            self.completeRequest(dataResponse, completion: completion)
        }
    }

    func request<T: Decodable>(containerType: T.Type, values: ParameterConvertible?, path: String, method: ReqMethod, completion: @escaping Completion<T>) {
        let dataRequest = createDataRequest(path: path, method: method, value: values)
        dataRequest?.responseData { dataResponse in
            self.completeRequest(dataResponse, completion: completion)
        }
    }

    // MARK: - Helpers
    private func createDataRequest(path: String,
                                   method: ReqMethod,
                                   value: ParameterConvertible?) -> DataRequest? {
        guard let value = value?.value else {
            return AF.request(base + path, method: method, parameters: nil,
            encoding: URLEncoding.httpBody, headers: nil)
        }
        return AF.request(base + path, method: method, parameters: value,
                          encoding: URLEncoding.httpBody, headers: nil)
    }
    
    private func completeRequest<T: Decodable>(_ dataResponse: AFDataResponse<Data>,
                                               completion: @escaping Completion<T>) {

        traceRequestMethodAndBody(dataResponse)

        let code = dataResponse.response?.statusCode ?? -1

        switch dataResponse.result {
        case .success(let data):
            traceLog("\nJSON: \(String(data: data, encoding: .ascii) ?? "{}")")
            print(T.self)
            if code < 400 && code > 0 {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                    traceLog("\nRequest succeeded: \(result)")
                } catch {
                    traceLog("\nfailed to decode, error: " + "\(error)" + error.localizedDescription)
                    let model = String(describing: T.self)
                    let body = String(data: data, encoding: .ascii) ?? "{}"
                    traceLog("\nbody : " + "\(body)")
                    let url = dataResponse.request?.url?.absoluteString
                    var additional: [String: String] = ["model": model, "body": body]
                    if let url = url {
                        additional["url"] = url
                    }
                    completion(.failure(GlobError(message: error.localizedDescription)))
                }
            } else {
                do {
                    let error = try GlobError(response: dataResponse)
                    traceLog("\nError decoded: " + "\(error)")
                    completion(.failure(error))
                } catch {
                    handleDecodingError(error, completion: completion)
                }
            }
        case .failure(let error):
            handleNetworkError(error, completion: completion)
        }
    }
    
    private func traceRequestMethodAndBody(_ dataResponse: AFDataResponse<Data>) {
        if let request = dataResponse.request {
            if NetworkLayer.fullDebug {
                debugPrint(NetworkLayer.sessionManager.request(request))
            }
            traceLog(
                "\n\n" +
                    "\nRequesting: \(request.url?.absoluteString ?? "No URL!")" +
                    "\nMethod: \(request.httpMethod ?? "Unknown method")" +
                "\nHeaders: \(request.allHTTPHeaderFields ?? [:])"
            )

            if let data = request.httpBody {
                traceLog("\nBody: \(String(data: data, encoding: .utf8) ?? "-")")
            } else {
                traceLog("\nBody: ")
            }
        }
    }
    
    private func handleDecodingError<T: Decodable>(_ error: Error, completion: @escaping Completion<T>) {
        traceLog("\nfailed error decode, error: " + "\(error)" + error.localizedDescription)
        completion(.failure(GlobError(message: error.localizedDescription)))
    }

    private func handleNetworkError<T: Decodable>(_ error: Error, completion: @escaping Completion<T>) {
        traceLog("\nnetwork error: \(error)")
        completion(.failure(GlobError(message: error.localizedDescription)))
    }
}

private func traceLog(_ string: String) {
    if NetworkLayer.fullDebug {
        print(string)
    }
}


private extension NetworkLayer {
    func prepareRequest(path: String,
                                method: ReqMethod,
                                value: ParameterConvertible?) -> URLRequest {

        let url = URL(string: base + path)!
        guard var request = try? URLRequest(url: url, method: method, headers: headers) else {
            fatalError("Could not create request from URL")
        }
        do {
            try request.httpBody = value?.asParameterData()
        } catch {
            fatalError(error.localizedDescription)
        }
        return request
    }
    
    func getPostString(params:[String: Any]) -> String {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}
