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

    func toImage(_ completion: @escaping (UIImage?) -> Void?) {
        DispatchQueue.main.async {
            let imageData = Data.init(base64Encoded: self, options: .init(rawValue: 0))
            let image = UIImage(data: imageData!)
           completion(image)
        }
    }
}

extension UIImage {
    var base64: String? {
        return jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
