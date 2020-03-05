//
//  MainSectionCoordinator.swift
//  Globe Avenue
//
//  Created by Imran Malik on 15/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

protocol MainSectionCoordinator {
    var initialController: UIViewController? { get }

    // MARK: Auth
    func showLogin()
    func doLogin<T: Decodable>(containerType: T.Type, values: ParameterConvertible, completion: @escaping Completion<APIResponse<T>>)

    func showSignup()
    func doSignup<T: Decodable>(containerType: T.Type, values: ParameterConvertible, completion: @escaping Completion<APIResponse<T>>)

    func showProfessionalSignup()
    
    func showForgotPassword()
}
