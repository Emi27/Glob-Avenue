//
//  HomeViewController.swift
//  Glob Avenue
//
//  Created by Imran Malik on 26/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let viewModel: HomeViewModel
    let logo = AppLogoView(frame: .zero)
    let categories = [Items(name: "", icon: UIImage(named: "category1")!),
                                  Items(name: "", icon: UIImage(named: "category2")!),
                                  Items(name: "", icon: UIImage(named: "category3")!),
                                  Items(name: "", icon: UIImage(named: "category4")!),
                                  Items(name: "", icon: UIImage(named: "category5")!)]

    lazy var scrollableMenu: ScrollableMenu = {
        let menu = ScrollableMenu(frame: .zero)
        view.addSubview(menu)
        menu.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(180)
        }
        menu.items = categories
        return menu
    }()

    // MARK: - Initilizar
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        logo.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        navigationItem.titleView = logo
        scrollableMenu.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.reload()
    }
}

extension HomeViewController: ScrollableMenuDelegate {

    func scrollableMenu(didSelectItemAt indexPath: IndexPath) {
       print(indexPath)
    }

}
