//
//  LoginViewModel.swift
//  Glob Avenue
//
//  Created by Imran Malik on 24/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import Foundation

protocol LoginProtocols {
    func showSignup()
    func showForgetPassword()
    func loginPressed()
}


class LoginViewModel: LoginProtocols {

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
        
    }
}
