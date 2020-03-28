//
//  SignupExtension.swift
//  Glob Avenue
//
//  Created by Imran Malik on 27/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

extension SignupViewController: UITextFieldDelegate {
    
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

extension SignupViewController {
    func setupElements() {
        [professionalButton, titleAccountDetails, usernameField, passwordField, confirmPasswordField,
         titlePersonalDetails, emailField, mobileField, locationField, signButton].forEach {
            self.contentView.addSubview($0)
        }

        titleAccountDetails.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Margin.verticalSpacingM)
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(28)
        }

        usernameField.snp.makeConstraints {
            $0.top.equalTo(titleAccountDetails.snp.bottom).offset(Margin.verticalSpacingL)
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(Margin.textFieldHeight)
        }

        passwordField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(Margin.textFieldHeight)
            $0.top.equalTo(usernameField.snp.bottom).offset(Margin.verticalSpacingL)
        }

        confirmPasswordField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(Margin.textFieldHeight)
            $0.top.equalTo(passwordField.snp.bottom).offset(Margin.verticalSpacingL)
        }

        titlePersonalDetails.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordField.snp.bottom).offset(Margin.verticalSpacingL*2)
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(28)
        }

        emailField.snp.makeConstraints {
            $0.top.equalTo(titlePersonalDetails.snp.bottom).offset(Margin.verticalSpacingL)
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(Margin.textFieldHeight)
        }

        mobileField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(Margin.verticalSpacingL)
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(Margin.textFieldHeight)
        }

        locationField.snp.makeConstraints {
            $0.top.equalTo(mobileField.snp.bottom).offset(Margin.verticalSpacingL)
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(Margin.textFieldHeight)
        }
        
        signButton.snp.makeConstraints {
            $0.top.equalTo(locationField.snp.bottom).offset(Margin.verticalSpacingL)
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
            $0.height.equalTo(Margin.textFieldHeight)
        }
        
        professionalButton.snp.makeConstraints {
            $0.top.equalTo(signButton.snp.bottom).offset(Margin.verticalSpacingL)
            $0.left.equalToSuperview().offset(Margin.left)
            $0.right.equalToSuperview().offset(-Margin.right)
        }
    }
}
