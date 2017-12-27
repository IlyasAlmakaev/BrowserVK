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
         // REVIEW: Класс содержит только статические ф-ии и не требует инициализации. Регистрировать его не имеет смысла.
        container.register(CocoaLumberjackService.self) { (r) in
            CocoaLumberjackService()
            }.inObjectScope(.container)
    }
}
