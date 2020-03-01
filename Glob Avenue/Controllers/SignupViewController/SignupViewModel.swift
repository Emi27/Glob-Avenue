//
//  SignupViewModel.swift
//  Glob Avenue
//
//  Created by Imran Malik on 24/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

protocol SignupProtocols {
    func showProfessionalReg()
}

class SignupViewModel: SignupProtocols {

    let coordinator: MainSectionCoordinator

    init(coordinator: MainSectionCoordinator) {
        self.coordinator = coordinator
    }

    func showProfessionalReg() {
        self.coordinator.showProfessionalSignup()
    }

    func doSignUp() {
        let values = ParamDictionary(["email":"test707@gmail.com", "device_type": "ios", "role": "1", "device_id": "asdk45894r5k34b5kj3hb45h3i4u5iu34hiuk5h34","password": "123456", "conf_password": "123456"])
        coordinator.doSignup(containerType: User.self, values: values) { (response) in
            switch response {
            case .success(let user): print(user)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func validateFields() {
        
    }

}
