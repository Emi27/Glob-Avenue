//
//  LoginViewController.swift
//  Globe Avenue
//
//  Created by Imran Malik on 15/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LoginViewController: UIViewController {

    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "logo")
        return imageView
    }()

    let logo = AppLogoView(frame: .zero)
    
    lazy var usernameField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Email"
        textField.placeholder = "xyz@mail.com"
        textField.delegate = self
        textField.keyboardType = .emailAddress
        textField.isRequired = true
        return textField
    }()

    lazy var passwordField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Password"
        textField.placeholder = "******"
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.isRequired = true
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "submit_btn"), for: .normal)
        return button
    }()

    lazy var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Signup", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()

    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .right
        return button
    }()

    let viewModel: LoginViewModel

    // MARK: - Initializers
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " "
        view.backgroundColor = .white
        addImageView()
        addFields()
        addSignUpButton()
        addSubmitButton()
        addForgotPassword()
    }

    private func addImageView() {
        view.addSubview(logo)
        logo.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
    }
    
    private
    func addFields() {
        view.addSubview(usernameField)
        usernameField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
            $0.top.equalTo(logo.snp.bottom).offset(80)
        }
        
        view.addSubview(passwordField)
        passwordField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
            $0.top.equalTo(usernameField.snp.bottom).offset(30)
        }
    }
    
    private
    func addSubmitButton() {
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
            $0.bottom.equalTo(signUpButton.snp.top).offset(-20)
        }
    }
    
    private
    func addForgotPassword() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints {
            $0.right.equalTo(passwordField.snp.right)
            $0.top.equalTo(passwordField.snp.bottom).offset(8)
            $0.width.equalTo(150)
        }
        forgotPasswordButton.addTarget(self, action: #selector(showForgotPassword), for: .touchUpInside)
    }

    private
    func addSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.height.equalTo(30)
            $0.bottom.equalToSuperview().offset(-40)
        }
        signUpButton.addTarget(self, action: #selector(showSignup), for: .touchUpInside)
    }

    @objc
    func showSignup() {
        viewModel.showSignup()
    }
    
    @objc
    func showForgotPassword() {
        viewModel.showForgetPassword()
    }
}

// MARK: - Delegates / Extensions
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameField {
            self.passwordField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
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
