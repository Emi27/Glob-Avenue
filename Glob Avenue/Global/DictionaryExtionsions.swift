//
//  DictionaryExtionsions.swift
//  Glob Avenue
//
//  Created by Imran Malik on 04/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
