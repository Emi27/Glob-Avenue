//
//  Reusable.swift
//  Glob Avenue
//
//  Created by Imran Malik on 27/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

protocol Reuseable {
    static var reuseId: String { get }
}

extension Reuseable {
    static var reuseId: String { return String(describing: self) }
}

protocol NibRepresentable: Reuseable {
    static func nib() -> UINib
}

extension NibRepresentable {
    static func nib() -> UINib {
        return UINib(nibName: reuseId, bundle: nil)
    }
    static func withOwner(owner: Any?) -> Self {
        return nib().instantiate(withOwner: owner, options: nil).first as! Self // swiftlint:disable:this force_cast
    }
}

extension UITableView {
    func register<T: Reuseable>(_ type: T.Type) where T: UITableViewCell {
        register(type.self, forCellReuseIdentifier: type.reuseId)
    }
    func register<T: UITableViewCell>(_ type: T.Type) where T: NibRepresentable {
        register(T.nib(), forCellReuseIdentifier: T.reuseId)
    }

    func dequeue<T: Reuseable>(_ type: T.Type) -> T? where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: type.reuseId) as? T
    }

    func dequeue<T: Reuseable>(_ type: T.Type, at indexPath: IndexPath) -> T {
        guard let reusableItem =  dequeueReusableCell(withIdentifier: type.reuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable of \(type)")
        }
        return reusableItem
    }
}

extension UICollectionView {
    func register<T: Reuseable>(_ type: T.Type) where T: UICollectionViewCell {
        register(type.self, forCellWithReuseIdentifier: type.reuseId)
    }

    func register<T: NibRepresentable>(_ type: T.Type) where T: UICollectionViewCell {
        register(T.nib(), forCellWithReuseIdentifier: T.reuseId)
    }

    func dequeue<T: Reuseable>(_ type: T.Type, at indexPath: IndexPath) -> T {
        guard let reusableItem =  dequeueReusableCell(withReuseIdentifier: type.reuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable of \(type)")
        }
        return reusableItem
    }
}

