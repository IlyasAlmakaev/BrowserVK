//
//  AIUserInfoAIUserInfoConfigurator.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import Swinject

/**
 @author Ilyas Almakaev
 Сборка компонетов для модуля UserInfo
 */

class UserInfoConfigurator {
    
    public var viewController: UserInfoViewController!
    public var moduleInput: UserInfoModuleInput!
    
    init(resolver: Resolver, input: UserInfoInputDataModel) {

        let userInfoViewController = UserInfoViewController()
        let router = UserInfoRouter(viewController: userInfoViewController)
        
        let presenter = UserInfoPresenter(userID: input.userID)
        presenter.view = userInfoViewController
        presenter.router = router
        
        let interactor = UserInfoInteractor(apiFacade: resolver.resolve(IApiFacade.self)!,
                                            vkRepository: resolver.resolve(IVkRepository.self)!)
        interactor.output = presenter
        
        presenter.interactor = interactor
        userInfoViewController.output = presenter
        
        viewController = userInfoViewController
        moduleInput = presenter
    }
    
}
