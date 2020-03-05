//
//  RegParamConvertible.swift
//  Glob Avenue
//
//  Created by Imran Malik on 04/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import Foundation

struct RegParamConvertible {
    var username: String = ""
    var companyName: String = ""
    var contactName: String = ""
    var email: String = ""
    var password: String = ""
    var phone: String = ""
    var confPassword: String = ""
    var location: String = ""
    var address: String = ""
    var zipCode: String = ""
    var logoUrl: String = ""
    var presentationUrl: String = ""

    var values = ["role": "1", "device_type": "ios", "device_id": "rhkehr8372yrhiedf"] as [String: Any]
    
    
    var normalParam: ParamDictionary {
        let updated = values.merging(["email": email, "username": username,
                                      "password": password, "conf_password": confPassword,
                                      "phone": phone, "location": location]) {_,_ in }
        return ParamDictionary(updated)
    }
}
