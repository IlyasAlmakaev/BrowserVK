//
//  SevisesAssembley.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import Swinject

/**
 @author Ilyas Almakaev
 Сборка для создания сервисов
 */

class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(IApiFacade.self) { (r) in
            ApiFacade()
            }.inObjectScope(.container)
        //TODO: узнать как инициализировать если надо
//        container.register(IRealmService.self) { (r) in
//            RealmService()
//            }.inObjectScope(.container)
    }
}
