//
//  ScrollableMenu.swift
//  Glob Avenue
//
//  Created by Imran Malik on 28/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

protocol ScrollableMenuDelegate {
    func scrollableMenu(didSelectItemAt indexPath: IndexPath)
}

class ScrollableMenu: UIView {

    var items: [Items]? {
        didSet {
            categoryCollection.reloadData()
        }
    }

    var delegate: ScrollableMenuDelegate?
    
    private lazy var categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        categoryCollection.register(CategoryCell.self)
        categoryCollection.backgroundColor = .white
    }
}

extension ScrollableMenu: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CategoryCell.self, at: indexPath)
        cell.icon = items?[indexPath.row].icon
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = frame.width / 6
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.scrollableMenu(didSelectItemAt: indexPath)
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell, cell.isSelected else {
            return
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell else {
            return
        }

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            cell.transform = .identity
        }) { _ in
        }
    }
}

struct Items {
    var name: String
    var icon: UIImage
}
