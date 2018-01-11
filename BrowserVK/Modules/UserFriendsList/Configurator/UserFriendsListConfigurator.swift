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

    init(resolver: Resolver, input: UserFriendsListInputDataModel) {
        let userFriendsListViewController = UserFriendsListViewController()
        let router = UserFriendsListRouter(viewController: userFriendsListViewController)

        let presenter = UserFriendsListPresenter(userID: input.userID)
        presenter.view = userFriendsListViewController
        presenter.router = router

        let interactor = UserFriendsListInteractor(apiFacade: resolver.resolve(IApiFacade.self)!)
        interactor.output = presenter

        presenter.interactor = interactor
        userFriendsListViewController.output = presenter
        
        viewController = userFriendsListViewController
    }

}
