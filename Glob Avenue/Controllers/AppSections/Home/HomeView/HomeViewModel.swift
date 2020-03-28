//
//  HomeViewModel.swift
//  Glob Avenue
//
//  Created by Imran Malik on 26/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

class HomeViewModel: HomeViewProtocols {

    let coordinator: MainSectionCoordinator
    private var group = DispatchGroup()
    private var automobiles: [Automobile] = []
    var onReload: (() -> Void)?
    var onErrors: (([GlobError]) -> Void)?
    
    // MARK: - Initializer
    init(coordinator: MainSectionCoordinator) {
        self.coordinator = coordinator
    }
 
    func reload() {
        group.enter()
        var updatedAutomobile: [Automobile] = []
        var updatedErrors: [GlobError] = []
        
        group.enter()
        coordinator.fetch(containerType: [Automobile].self) { (response) in
            switch response {
            case .success(let result): print(result.data)
                updatedAutomobile = result.data
            case .failure(let error): print(error.localizedDescription)
                updatedErrors.append(error)
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            self.automobiles = updatedAutomobile
            print(self.automobiles)
            if updatedErrors.count > 0 {
                //self.onErrors?(updatedErrors)
            } else {
                //self.onReload?(self)
            }
        }

        self.group.leave()
    }
}


protocol HomeViewProtocols {
    func reload()
}
