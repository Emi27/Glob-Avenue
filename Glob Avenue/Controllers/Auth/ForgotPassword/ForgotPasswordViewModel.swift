//
//  ForgotPasswordViewModel.swift
//  Glob Avenue
//
//  Created by Imran Malik on 01/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol ForgotUIDelegate {
    func showError(message: String)
    func showSuccess(message: String)
}


class ForgotPasswordViewModel {

    var delegate: ForgotUIDelegate?
    let coordinator: MainSectionCoordinator

    init(coordinator: MainSectionCoordinator) {
        self.coordinator = coordinator
    }
    
    func doForgot(email: String) {
        SVProgressHUD.show(withStatus: "Please wait")
        let values = ParamDictionary(["email": email])
        coordinator.forgotPassword(containerType: ForgotPassword.self, values: values) { (response) in
            SVProgressHUD.dismiss()
            switch response {
            case .success(let result):
                if result.status {
                    self.delegate?.showSuccess(message: result.message)
                } else {
                    self.delegate?.showError(message: result.message)
                }
            case .failure(let error): print(error.localizedDescription)
            self.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
}

struct ForgotPassword: GlobCodable {
    var message: String
    var status: Bool
    
    enum CodingKeys: String, CodingKey {
        case message = "msg"
        case status = "status"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Bool.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.message, forKey: .message)
    }
}
