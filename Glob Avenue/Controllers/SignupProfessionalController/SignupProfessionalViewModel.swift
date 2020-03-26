//
//  SignupProfessionalViewModel.swift
//  Glob Avenue
//
//  Created by Imran Malik on 28/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignupProfessionalViewModel {
    
    let coordinator: MainSectionCoordinator
    
    var userName: String = ""
    var password: String = ""
    var confPassword: String = ""
    var companyName: String = ""
    var companyEmail: String = ""
    var companyMobile: String = ""
    var companyAddress: String = ""
    var companyZip: String = ""
    var logoString: String = ""
    var presentationUrl: URL? {
        didSet {
            do {
                let data = try Data(contentsOf: presentationUrl!)
                self.presentationString = data.base64EncodedString()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var presentationString: String = ""

    init(coordinator: MainSectionCoordinator) {
        self.coordinator = coordinator
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
    func updateCompanyName(text: String) {
        companyName = text
    }

    @objc
    func updateEmail(text: String) {
        companyEmail = text
    }

    @objc
    func updateMobile(text: String) {
        companyMobile = text
    }

    @objc
    func updateAddress(text: String) {
        companyAddress = text
    }

    @objc
    func updateZip(text: String) {
        companyZip = text
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
        } else if companyEmail.isEmpty {
            return .email("Please enter email address")
        } else if !companyEmail.isValidEmail {
            return .email("Please enter valid email address")
        }
        return .none
    }

    func doSignUp() {
        SVProgressHUD.show(withStatus: "Registering you with Glob Avenue..")
        let values = RegParamConvertible(username: userName, contactName: companyName, email: companyEmail, password: password, phone: companyMobile, confPassword: confPassword, address: companyAddress, zipCode: companyZip, logoUrl: logoString, presentationUrl: "").professionalParam
        print(presentationString)
        coordinator.doSignup(containerType: User.self, values: values) { (response) in
            SVProgressHUD.dismiss()
            switch response {
            case .success(let result): print("here is the user object",result.data)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
