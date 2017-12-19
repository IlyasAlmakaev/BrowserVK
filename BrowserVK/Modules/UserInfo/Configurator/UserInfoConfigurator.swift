//
//  AIUserInfoAIUserInfoConfigurator.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import Swinject

class UserInfoConfigurator {
    
    public var viewController: UserInfoViewController!
    public var moduleInput: UserInfoModuleInput!
    
    //    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
    //
    //        if let viewController = viewInput as? UserInfoViewController {
    //            configure(viewController: viewController)
    //        }
    //    }
    
    init(resolver: Resolver, input: UserInfoInputDataModel) {
    
//    func configure(viewController: UserInfoViewController, userID: Int) -> UserInfoViewController {
        let userInfoViewController = UserInfoViewController()
        let router = UserInfoRouter()
        
        let presenter = UserInfoPresenter(userID: input.userID)
        presenter.view = userInfoViewController
        presenter.router = router
        
        let interactor = UserInfoInteractor(apiFacade: resolver.resolve(IApiFacade.self)!, vkRepository: resolver.resolve(IVkRepository.self)!)
        interactor.output = presenter
        
        let apiFacade = ApiFacade()
        apiFacade.userInfoInterator = interactor
        interactor.apiFacade = apiFacade
        
        let vkRepository = VkRepository()
        vkRepository.userInfoInteractor = interactor
        interactor.vkRepository = vkRepository
        
        presenter.interactor = interactor
        userInfoViewController.output = presenter
        
        viewController = userInfoViewController
        moduleInput = presenter
    }
    
}
