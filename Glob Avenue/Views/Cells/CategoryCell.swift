//
//  CategoryCell.swift
//  Glob Avenue
//
//  Created by Imran Malik on 27/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, Reuseable {
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return imageView
    }()

    var icon: UIImage? {
        didSet {
            iconView.image = icon
        }
    }
    
    override func prepareForReuse() {
        iconView.image = nil
    }
}
