//
//  Bundle+Extenstions.swift
//  Glob Avenue
//
//  Created by Imran Malik on 18/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit
import Kingfisher

extension Bundle {

    static var current: Bundle {
        class __ { }
        return Bundle(for: __.self)
    }

}

