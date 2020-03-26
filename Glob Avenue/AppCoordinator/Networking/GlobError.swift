import Foundation
import Alamofire

public struct GlobError: Error, LocalizedError {
    public var message: String?
    public var status: Int? = -1
    public var localizedDescription: String {
        return self.message ?? ""
    }

    public init(message: String) {
        self.message = message
    }

    public init(parameters: ErrorParameters, code: Int) {
        self.message = parameters.msg
        self.status = code
    }

    public init(response: AFDataResponse<Data>) throws {
        let code = response.response?.statusCode ?? -1
        switch response.result {
        case .success(let data):
            do {
                let decodedMessages = try ErrorParameters.decode(data: data)
                self.init(parameters: decodedMessages, code: code)
            } catch {
                throw error
            }
        case .failure(let error):
            throw error
        }
    }
}

public struct ErrorParameters: Decodable {
    let msg: String
    let status: Int
}
