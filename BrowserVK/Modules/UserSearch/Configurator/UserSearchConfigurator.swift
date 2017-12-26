//
//  AIUserSearchAIUserSearchConfigurator.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import Swinject
/**
 @author Ilyas Almakaev
 Сборка компонетов для модуля UserSearch
 */

class UserSearchConfigurator {
    
    public var viewController: UserSearchViewController!
    public var moduleInput: UserSearchModuleInput!
    
    init(resolver: Resolver, input: UserSearchInputDataModel) {

        let userSearchViewController = UserSearchViewController()
        let router = UserSearchRouter(controller: userSearchViewController,
                                      factory: resolver.resolve(UserInfoControllerFactory.self)!)
        
        let presenter = UserSearchPresenter()
        presenter.view = userSearchViewController
        presenter.router = router
        
        let interactor = UserSearchInteractor(apiFacade: resolver.resolve(IApiFacade.self)!,
                                              vkRepository: resolver.resolve(IVkRepository.self)!)
        interactor.output = presenter
        
        presenter.interactor = interactor
        userSearchViewController.output = presenter
    
        viewController = userSearchViewController
        moduleInput = presenter
    }
    
}
