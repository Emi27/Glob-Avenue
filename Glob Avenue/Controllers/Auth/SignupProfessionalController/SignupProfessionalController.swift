//
//  SignupProfessionalController.swift
//  Glob Avenue
//
//  Created by Imran Malik on 28/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit
import AVFoundation

class SignupProfessionalController: UIViewController, StoryboardRepresentable {

    var viewModel: SignupProfessionalViewModel!
    var imagePicker: ImagePicker!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var previewVideo: UIImageView!
    
    // MARK: - Account Details Outlets
    @IBOutlet weak var userNameField: HighlightingTextField! {
        didSet {
            userNameField.title = "User name"
            userNameField.placeholder = "User name"
            userNameField.delegate = self
            userNameField.isRequired = true
        }
    }

    @IBOutlet weak var passwordField: HighlightingTextField! {
        didSet {
            passwordField.title = "Password"
            passwordField.placeholder = "Password"
            passwordField.delegate = self
            passwordField.isSecureTextEntry = true
            passwordField.isRequired = true
        }
    }

    @IBOutlet weak var confirmPasswordField: HighlightingTextField! {
        didSet {
            confirmPasswordField.title = "Confirm password"
            confirmPasswordField.placeholder = "Password"
            confirmPasswordField.delegate = self
            confirmPasswordField.isSecureTextEntry = true
            confirmPasswordField.isRequired = true
        }
    }
    
    // MARK: - Company Details Outlets
    @IBOutlet weak var companyNameField: HighlightingTextField! {
        didSet {
            companyNameField.title = "Contact name"
            companyNameField.placeholder = "Leonardo Oliveira"
            companyNameField.delegate = self
        }
    }

    @IBOutlet weak var companyEmailField: HighlightingTextField! {
        didSet {
            companyEmailField.title = "Contact email ID"
            companyEmailField.placeholder = "cole_spencer@yahoo.com"
            companyEmailField.delegate = self
            companyEmailField.keyboardType = .emailAddress
            companyEmailField.isRequired = true
        }
    }

    @IBOutlet weak var companyPhoneField: HighlightingTextField! {
        didSet {
            companyPhoneField.title = "Contact phone number"
            companyPhoneField.placeholder = "466-706-3114"
            companyPhoneField.delegate = self
            companyPhoneField.keyboardType = .phonePad
        }
    }

    @IBOutlet weak var companyAddressField: HighlightingTextField! {
        didSet {
            companyAddressField.title = "Address"
            companyAddressField.placeholder = "168 Lamont Shores Suite 571"
            companyAddressField.delegate = self
        }
    }

    @IBOutlet weak var companyZipField: HighlightingTextField! {
        didSet {
            companyZipField.title = "Zipcode"
            companyZipField.placeholder = "12507"
            companyZipField.delegate = self
            companyZipField.keyboardType = .phonePad
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Professional Signup"
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender, mediaType: .image)
    }
    
    @IBAction func uploadVideo(_ sender: UIButton) {
        self.imagePicker.present(from: sender, mediaType: .video)
    }
    
    func checkValidityOfFields() -> Bool {
        resetAllError()
        var isAllValid = false
        switch viewModel.validateFields() {
        case .userName(let message): userNameField.error = message
        case .password(let message): passwordField.error = message
        case .confPassword(let message): confirmPasswordField.error = message
        case .passwordNotMatch(let message):
            passwordField.error = message
            confirmPasswordField.error = message
        case .email(let message): companyEmailField.error = message
        case .none: isAllValid = true
        }
        return isAllValid
    }
    
    func resetAllError() {
        [userNameField, passwordField, confirmPasswordField, companyEmailField].forEach {
            $0.error = nil
        }
    }
    
    @IBAction func editingChnaged(_ sender: HighlightingTextField) {
        guard let text = sender.text else {
            return
        }
        switch sender {
        case userNameField: viewModel.updateUserName(text: text)
        case passwordField: viewModel.updatePassword(text: text)
        case confirmPasswordField: viewModel.updateConfPassword(text: text)
        case companyNameField: viewModel.updateCompanyName(text: text)
        case companyEmailField: viewModel.updateEmail(text: text)
        case companyPhoneField: viewModel.updateMobile(text: text)
        case companyAddressField: viewModel.updateAddress(text: text)
        case companyZipField: viewModel.updateZip(text: text)
        default: break
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        if checkValidityOfFields() {
            viewModel.doSignUp()
        }
    }
    
}

extension SignupProfessionalController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        DispatchQueue.main.async {
            self.previewImage.image = image
            self.viewModel.logoString = image?.base64 ?? ""
        }
    }

    func didSelect(video: URL?) {
        if let path = video {
            DispatchQueue.main.async {
                self.previewVideo.image = path.thumbnail
                self.viewModel.presentationUrl = path
            }
        }
    }
}

extension SignupProfessionalController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            if textField == self.usernameField {
//                self.passwordField.becomeFirstResponder()
//            } else {
//                view.endEditing(true)
//            }
            return true
        }

        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //        if viewModel.hasValidInputs {
    //            textField.returnKeyType = .go
    //        } else {
    //            textField.returnKeyType = .next
    //        }
            return true
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            self.view.layoutIfNeeded()
        }
}
