//
//  SignupProfessionalController.swift
//  Glob Avenue
//
//  Created by Imran Malik on 28/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

class SignupProfessionalController: UIViewController, StoryboardRepresentable {

    var viewModel: SignupProfessionalViewModel!
    var imagePicker: ImagePicker!

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
            companyNameField.isRequired = true
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
            companyPhoneField.isRequired = true
        }
    }

    @IBOutlet weak var companyAddressField: HighlightingTextField! {
        didSet {
            companyAddressField.title = "Address"
            companyAddressField.placeholder = "168 Lamont Shores Suite 571"
            companyAddressField.delegate = self
            companyAddressField.isRequired = true
        }
    }

    @IBOutlet weak var companyZipField: HighlightingTextField! {
        didSet {
            companyZipField.title = "Zipcode"
            companyZipField.placeholder = "12507"
            companyZipField.delegate = self
            companyZipField.keyboardType = .phonePad
            companyZipField.isRequired = true
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
    
}

extension SignupProfessionalController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        //self.imageView.image = image
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
