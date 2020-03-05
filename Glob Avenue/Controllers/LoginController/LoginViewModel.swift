//
//  LoginViewModel.swift
//  Glob Avenue
//
//  Created by Imran Malik on 24/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
protocol LoginProtocols {
    func showSignup()
    func showForgetPassword()
    func loginPressed()
}

protocol LoginUiDelegates {
    func showSuccess(message: String)
    func showError(message: String)
}

class LoginViewModel: LoginProtocols {
    var email: String = ""
    var password: String = ""
    var delegate: LoginUiDelegates?
    let coordinator: MainSectionCoordinator

    init(coordinator: MainSectionCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: Login Protocols
    func showSignup() {
        coordinator.showSignup()
    }

    func showForgetPassword() {
        coordinator.showForgotPassword()
    }

    func loginPressed() {
        SVProgressHUD.show(withStatus: "Log in with Glob Avenue..")
        let values = ParamDictionary(["email": email, "password": password])
        coordinator.doLogin(containerType: User.self, values: values) { (response) in
            SVProgressHUD.dismiss()
            switch response {
            case .success(let result): print("here is the user object",result.data)
            self.delegate?.showSuccess(message: "Login successfully.")
            case .failure(let error): print(error.localizedDescription)
            self.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func validateFields() -> FieldError {
        if email.isEmpty {
            return .email("Please enter email address.")
        } else if !email.isValidEmail {
            return .email("Please enter valid email address")
        } else if password.isEmpty {
            return .password("Please enter password")
        } else if password.replacingOccurrences(of: " ", with: "").count < 3 {
            return .password("Please enter valid password")
        }
        return .none
    }
    
}
