//
//  AppLogoView.swift
//  Glob Avenue
//
//  Created by Imran Malik on 24/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import Foundation
import Kingfisher

class AppLogoView: AnimatedImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addLogo()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutIfNeeded() {
        addLogo()
    }
    
    private func addLogo() {
        if let path = logoPath {
            kf.setImage(with: path)
        }
        contentMode = .scaleAspectFit
    }

    private lazy var logoPath: URL? = {
        guard let path = Bundle.current.path(forResource: "globeLogo", ofType: "gif") else {
            return nil
        }
        return URL(fileURLWithPath: path)
    }()
}
