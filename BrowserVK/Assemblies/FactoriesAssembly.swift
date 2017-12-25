//
//  FactoriesAssembly.swift
//  BrowserVK
//
//  Created by Ильяс on 19.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import Swinject

class FactoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserInfoControllerFactory.self) { (r) in
            UserInfoControllerFactory(container: r)
        }
    }
}
