//
//  PostAdViewController.swift
//  Glob Avenue
//
//  Created by Imran Malik on 26/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

class PostAdViewController: UIViewController {

    let viewModel: PostAdViewModel

    init(viewModel: PostAdViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
