//
//  UserInfoControllerFactory.swift
//  BrowserVK
//
//  Created by Ильяс on 19.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import Swinject

class UserInfoControllerFactory  {
    
    private var container: Resolver!
    
    init(container: Resolver) {
        self.container = container
    }
    
    func controller(input: UserInfoInputDataModel) -> UserInfoConfigurator? {
        return container.resolve(UserInfoConfigurator.self, argument: input)
    }}
