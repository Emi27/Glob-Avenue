//
//  DefaultTabCoordinator+Home.swift
//  Glob Avenue
//
//  Created by Imran Malik on 27/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

extension DefaultTabCoordinator {
    func fetch<T: Decodable>(containerType: T.Type, completion: @escaping Completion<APIResponse<T>>) {
        api.request(containerType: containerType, method: .get, values: nil, path: "getAutomobile", completion: completion)
    }
}
