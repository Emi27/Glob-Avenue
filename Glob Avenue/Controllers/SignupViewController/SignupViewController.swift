//
//  SignupViewController.swift
//  Glob Avenue
//
//  Created by Imran Malik on 24/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    let viewModel: SignupViewModel

    // MARK: - Initializers
    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        return scrollView
    }()

    lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.snp.edges)
            $0.height.equalTo(scrollView.snp.height).offset(UIDevice.isBazzelLess ? -80 : 150)
            $0.width.equalTo(scrollView.snp.width)
        }
        return contentView
    }()

    lazy var professionalButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Professional Registration", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.setImage(UIImage(named: "right-arrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageView?.tintColor = .black
        button.addTarget(self, action: #selector(showProfessionalReg), for: .touchUpInside)
        return button
    }()

    // MARK: - Account Details fiels
    lazy var titleAccountDetails: UILabel = {
        let label = UILabel()
        label.apply(color: .textBlack, fontStyle: .headingM)
        label.text = "Account Details"
        return label
    }()

    lazy var usernameField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "User name"
        textField.placeholder = "User name"
        textField.delegate = self
        textField.isRequired = true
        textField.addTarget(self, action: #selector(updateUserName(textField:)), for: .editingChanged)
        return textField
    }()

    lazy var passwordField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Password"
        textField.placeholder = "Password"
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.isRequired = true
        textField.addTarget(self, action: #selector(updatePassword(textField:)), for: .editingChanged)
        return textField
    }()

    lazy var confirmPasswordField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Confirm password"
        textField.placeholder = "Confirm password"
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.isRequired = true
        textField.addTarget(self, action: #selector(updateConfPassword(textField:)), for: .editingChanged)
        return textField
    }()

    // MARK: - Personal Details fields
    lazy var titlePersonalDetails: UILabel = {
        let label = UILabel()
        label.apply(color: .textBlack, fontStyle: .headingM)
        label.text = "Personal Details"
        return label
    }()

    lazy var emailField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Email ID"
        textField.placeholder = "example@mail.com"
        textField.delegate = self
        textField.keyboardType = .emailAddress
        textField.isRequired = true
        textField.addTarget(self, action: #selector(updateEmail(textField:)), for: .editingChanged)
        return textField
    }()

    lazy var mobileField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Mobile number"
        textField.placeholder = "XXXXXX9876"
        textField.delegate = self
        textField.keyboardType = .phonePad
        textField.addTarget(self, action: #selector(updateMobile(textField:)), for: .editingChanged)
        return textField
    }()

    lazy var locationField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Location"
        textField.placeholder = "Paris"
        textField.delegate = self
        textField.addTarget(self, action: #selector(updateLocation(textField:)), for: .editingChanged)
        return textField
    }()

    lazy var signButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "submit_btn"), for: .normal)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()

    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        setupElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Personal Signup"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @objc
    func signUp() {
        if checkValidityOfFields() {
            viewModel.doSignUp()
        }
    }

    func checkValidityOfFields() -> Bool {
        resetAllError()
        var isAllValid = false
        switch viewModel.validateFields() {
        case .userName(let message): usernameField.error = message
        case .password(let message): passwordField.error = message
        case .confPassword(let message): confirmPasswordField.error = message
        case .passwordNotMatch(let message):
            passwordField.error = message
            confirmPasswordField.error = message
        case .email(let message): emailField.error = message
        case .none: isAllValid = true
        }
        return isAllValid
    }
    
    func resetAllError() {
        [usernameField, passwordField, confirmPasswordField, emailField].forEach {
            $0.error = nil
        }
    }
    
    @objc
    func showProfessionalReg() {
        viewModel.showProfessionalReg()
    }
    
    @objc
    func updateUserName(textField: HighlightingTextField) {
        if let text = textField.text {
            viewModel.userName = text
        }
    }

    @objc
    func updatePassword(textField: HighlightingTextField) {
        if let text = textField.text {
            viewModel.password = text
        }
    }

    @objc
    func updateConfPassword(textField: HighlightingTextField) {
        if let text = textField.text {
            viewModel.confPassword = text
        }
    }

    @objc
    func updateEmail(textField: HighlightingTextField) {
        if let text = textField.text {
            viewModel.email = text
        }
    }

    @objc
    func updateMobile(textField: HighlightingTextField) {
        if let text = textField.text {
            viewModel.mobile = text
        }
    }
    
    @objc
    func updateLocation(textField: HighlightingTextField) {
        if let text = textField.text {
            viewModel.location = text
        }
    }
}

extension SignupViewController: SignupUiDelegate {
    func showSuccess(message: String) {
        showSuccessBanner(message: message)
    }

    func showError(message: String) {
        showFailBanner(message: message)
    }
}
