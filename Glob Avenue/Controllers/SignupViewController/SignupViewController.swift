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
        return textField
    }()

    lazy var passwordField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Password"
        textField.placeholder = "Password"
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.isRequired = true
        return textField
    }()

    lazy var confirmPasswordField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Confirm password"
        textField.placeholder = "Confirm password"
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.isRequired = true
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
        return textField
    }()

    lazy var mobileField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Mobile number"
        textField.placeholder = "XXXXXX9876"
        textField.delegate = self
        textField.keyboardType = .phonePad
        textField.isRequired = true
        return textField
    }()

    lazy var locationField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Location"
        textField.placeholder = "Paris"
        textField.delegate = self
        textField.isRequired = true
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
        viewModel.doSignUp()
    }

    @objc
    func showProfessionalReg() {
        viewModel.showProfessionalReg()
    }
}
