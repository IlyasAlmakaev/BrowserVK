//
//  RepositoriesAssembly.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import Swinject

/**
 @author Ilyas Almakaev
 Сборка для создания репозитория
 */

class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(IVkRepository.self) { (r) in
            let realmService = RealmService() // REVIEW: Не правильно создавать для каждого репозитория свой realm
            let vkRepository = VkRepository(realmService: realmService) // REVIEW: VkRepository(realmService: r.resolve(RealmService.self)!)
            return vkRepository
        }.inObjectScope(.container)
    }
}
