//
//  MainContainer.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import Swinject
import RealmSwift

/**
 @author Ilyas Almakaev
 Сборка модулей
 */

class MainContainer
{
    
    var c: Container!
    
    init(window: UIWindow) {
        c = Container()
        let assembler = Assembler(container: c)
        assembler.apply(assemblies: [RepositoriesAssembly(),
                                     ServicesAssembly(),
                                     ControllersAssembly(),
                                     FactoriesAssembly()])
        
        let viewController = c.resolve(UserSearchConfigurator.self, argument: UserSearchInputDataModel())?.viewController
        
        let startService = StartService()
        startService.start(window: window, viewController: viewController!)
        startService.startLogger()
    }
}
