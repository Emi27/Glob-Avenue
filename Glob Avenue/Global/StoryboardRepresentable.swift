//
//  StoryboardRepresentable.swift
//  Glob Avenue
//
//  Created by Imran Malik on 28/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

protocol StoryboardRepresentable {

}

extension StoryboardRepresentable where Self: UIViewController {

    static var sbID: String { return String(describing: Self.self) }

    static func instance() -> Self {
        let storyboard = UIStoryboard(name: sbID, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: sbID) as? Self else {
            fatalError("Storyboard representable failed for \(sbID)")
        }
        return controller
    }
}
