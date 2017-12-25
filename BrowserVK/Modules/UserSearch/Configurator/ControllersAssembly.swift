//
//  ControllersAssembly.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import Swinject

class ControllersAssembly: Assembly {    
    func assemble(container: Container) {
        container.register(UserSearchConfigurator.self) { (r, moduleInput) in
            UserSearchConfigurator(resolver: r, input: moduleInput)
        }
        
        container.register(UserInfoConfigurator.self) { (r, moduleInput) in
            UserInfoConfigurator(resolver: r, input: moduleInput)
        }
    }
}
