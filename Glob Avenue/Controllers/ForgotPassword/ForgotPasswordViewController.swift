//
//  ForgotPasswordViewController.swift
//  Glob Avenue
//
//  Created by Imran Malik on 01/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    lazy var usernameField: HighlightingTextField = {
        let textField = HighlightingTextField(frame: .zero)
        textField.title = "Email"
        textField.placeholder = "xyz@mail.com"
        textField.keyboardType = .emailAddress
        textField.isRequired = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "submit_btn"), for: .normal)
        return button
    }()

    let logo = AppLogoView(frame: .zero)
    let viewModel: ForgotPasswordViewModel
    
    // MARK: - Initializers
    init(viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Forgot Password"
        view.backgroundColor = .white
        addLogo()
        addUiElements()
        viewModel.delegate = self
    }

    private func addLogo() {
        view.addSubview(logo)
        logo.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
    }

    private func addUiElements() {
        view.addSubview(usernameField)
        usernameField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(Margin.textFieldHeight)
            $0.centerY.equalTo(view.snp.centerY).offset(-2*Margin.textFieldHeight)
        }

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(Margin.textFieldHeight)
            $0.bottom.equalToSuperview().offset(-Margin.textFieldHeight)
            //$0.top.equalTo(usernameField.snp.bottom).offset(Margin.textFieldHeight*3)
        }
        loginButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
    }

    @objc
    func loginClicked() {
        guard let email = usernameField.text else {
            return
        }
        viewModel.doForgot(email: email)
    }
}

extension ForgotPasswordViewController: ForgotUIDelegate {
    func showError(message: String) {
        showFailBanner(message: message)
    }

    func showSuccess(message: String) {
        showSuccessBanner(message: message)
    }
}
