//
//  RepositoriesAssembly.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import Swinject

class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(IVkRepository.self) { (r) in
            VkRepository()
        }
    }
}
