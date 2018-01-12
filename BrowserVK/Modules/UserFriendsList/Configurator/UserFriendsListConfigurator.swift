//
//  AIUserFriendsListAIUserFriendsListConfigurator.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit
import Swinject

/**
 @author Ilyas Almakaev
 Сборка компонетов для модуля UserFriends
 */

class UserFriendsListConfigurator {
    
    public var viewController: UserFriendsListViewController!
    public var moduleInput: UserFriendsListModuleInput!

    init(resolver: Resolver, input: UserFriendsListInputDataModel) {
        let userFriendsListViewController = UserFriendsListViewController()
        let router = UserFriendsListRouter(controller: userFriendsListViewController, factory: resolver.resolve(UserInfoControllerFactory.self)!)

        let presenter = UserFriendsListPresenter(userID: input.userID, router: router)
        presenter.view = userFriendsListViewController

        let interactor = UserFriendsListInteractor(apiFacade: resolver.resolve(IApiFacade.self)!)
        interactor.output = presenter

        presenter.interactor = interactor
        userFriendsListViewController.output = presenter
        
        viewController = userFriendsListViewController
        moduleInput = presenter
    }

}
