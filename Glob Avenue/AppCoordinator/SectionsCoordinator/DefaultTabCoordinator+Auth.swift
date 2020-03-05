//
//  DefaultTabCoordinator+Auth.swift
//  Glob Avenue
//
//  Created by Imran Malik on 24/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

extension DefaultTabCoordinator {

    func showLogin() {
        let viewModel = LoginViewModel(coordinator: self)
        let loginController = LoginViewController(viewModel: viewModel)
        present(controller: loginController, animated: false, embeddInNav: true, fullScreen: true)
    }

    func doLogin<T>(containerType: T.Type, values: ParameterConvertible, completion: @escaping ((Result<APIResponse<T>, Error>) -> Void)) where T : Decodable, T : Encodable {
        api.request(containerType: containerType, method: .post, values: values, path: "login", completion: completion)
    }
}

extension DefaultTabCoordinator {
    func showSignup() {
        let viewModel = SignupViewModel(coordinator: self)
        let controller = SignupViewController(viewModel: viewModel)
        displayContent(controller)
    }

    func showProfessionalSignup() {
        let controller = SignupProfessionalController.instance()
        controller.viewModel = SignupProfessionalViewModel(coordinator: self)
        displayContent(controller)
    }

    func doSignup<T>(containerType: T.Type, values: ParameterConvertible, completion: @escaping Completion<APIResponse<T>>) where T : Decodable {
        api.request(containerType: containerType, method: .post, values: values, path: "registerUser", completion: completion)
    }
}

extension DefaultTabCoordinator {
    func showForgotPassword() {
        let viewModel = ForgotPasswordViewModel(coordinator: self)
        let controller = ForgotPasswordViewController(viewModel: viewModel)
        displayContent(controller)
    }
}
