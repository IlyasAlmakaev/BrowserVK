//
//  SevisesAssembley.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import Swinject

class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(IApiFacade.self) { (r) in
           ApiFacade()
        }
    }
}
