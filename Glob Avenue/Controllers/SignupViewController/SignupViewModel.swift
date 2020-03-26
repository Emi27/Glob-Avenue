//
//  SignupViewModel.swift
//  Glob Avenue
//
//  Created by Imran Malik on 24/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SignupProtocols {
    func showProfessionalReg()
}

protocol SignupUiDelegate {
    func showSuccess(message: String)
    func showError(message: String)
}

class SignupViewModel: SignupProtocols {

    var userName: String = ""
    var password: String = ""
    var confPassword: String = ""
    var email: String = ""
    var mobile: String = ""
    var location: String = ""
    
    var validateUserName: Bool = false
    var delegate: SignupUiDelegate?

    let coordinator: MainSectionCoordinator

    init(coordinator: MainSectionCoordinator) {
        self.coordinator = coordinator
    }

    func showProfessionalReg() {
        self.coordinator.showProfessionalSignup()
    }

    func doSignUp() {
        SVProgressHUD.show(withStatus: "Registering you with Glob Avenue..")
        let values = RegParamConvertible(username: userName, email: email, password: password,
                                         phone: mobile, confPassword: confPassword,
                                         location: location).normalParam
        print(values.value)
        coordinator.doSignup(containerType: User.self, values: values) { (response) in
            SVProgressHUD.dismiss()
            switch response {
            case .success(let result): print("here is the user object",result.data)
            self.delegate?.showSuccess(message: "Registered successfully.")
            case .failure(let error): print(error.localizedDescription)
            self.delegate?.showError(message: error.localizedDescription)
            }
        }
    }

    // MARK: - Values updating
    @objc
    func updateUserName(text: String) {
        userName = text
    }

    @objc
    func updatePassword(text: String) {
        password = text
    }

    @objc
    func updateConfPassword(text: String) {
        confPassword = text
    }

    @objc
    func updateEmail(text: String) {
        email = text
    }

    @objc
    func updateModile(text: String) {
        mobile = text
    }

    @objc
    func updateLocation(text: String) {
        location = text
    }

    func validateFields() -> FieldError {
        if userName.isEmpty {
            return .userName("Please enter user name")
        } else if password.isEmpty {
            return .password("Please enter password")
        } else if password.replacingOccurrences(of: " ", with: "").count < 3 {
            return .password("Please enter valid password")
        } else if confPassword.isEmpty {
            return .confPassword("Please enter confirm password")
        } else if password != confPassword {
            return .passwordNotMatch("Passwords are not matched")
        } else if email.isEmpty {
            return .email("Please enter email address")
        } else if !email.isValidEmail {
            return .email("Please enter valid email address")
        }
        return .none
    }

}

enum FieldError {
    case userName(String)
    case password(String)
    case confPassword(String)
    case email(String)
    case passwordNotMatch(String)
    case none
}
