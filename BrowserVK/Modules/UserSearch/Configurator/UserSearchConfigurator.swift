//
//  AIUserSearchAIUserSearchConfigurator.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import Swinject

class UserSearchConfigurator {
    
    public var viewController: UserSearchViewController!
    public var moduleInput: UserSearchModuleInput!
    
    //    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
    //
    //        if let viewController = viewInput as? UserSearchViewController {
    //            configure(viewController: viewController)
    //        }
    //    }
    
    init(resolver: Resolver, input: UserSearchInputDataModel) {
    
 //   func configure(viewController: UserSearchViewController) -> UIViewController {
        let userSearchViewController = UserSearchViewController()
        
        let router = UserSearchRouter(controller: userSearchViewController, factory: resolver.resolve(UserInfoControllerFactory.self)!)
        
        let presenter = UserSearchPresenter()
        presenter.view = userSearchViewController
        presenter.router = router
        
        let interactor = UserSearchInteractor(apiFacade: resolver.resolve(IApiFacade.self)!, vkRepository: resolver.resolve(IVkRepository.self)!)
        interactor.output = presenter
        
        let apiFacade = ApiFacade()
        apiFacade.userSearchInteractor = interactor
        interactor.apiFacade = apiFacade
        
        let vkRepository = VkRepository()
        vkRepository.userSearchInteractor = interactor
        interactor.vkRepository = vkRepository
        
   //     let navigation = UINavigationController(rootViewController: viewController)
        
        presenter.interactor = interactor
        userSearchViewController.output = presenter
    
        viewController = userSearchViewController
        moduleInput = presenter
    }
    
}
