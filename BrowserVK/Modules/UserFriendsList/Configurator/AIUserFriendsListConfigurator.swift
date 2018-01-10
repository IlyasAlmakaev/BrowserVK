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
        let router = UserFriendsListRouter()

        let presenter = UserFriendsListPresenter(userID: input.userID)
        presenter.view = viewController
        presenter.router = router

        let interactor = UserFriendsListInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        userFriendsListViewController.output = presenter
        
        viewController = userFriendsListViewController
    }

}
