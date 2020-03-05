//
//  StringExtensions.swift
//  Glob Avenue
//
//  Created by Imran Malik on 04/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

extension String {
    var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
