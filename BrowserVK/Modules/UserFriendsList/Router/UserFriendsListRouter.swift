//
//  UserFriendsListAIUserFriendsListRouter.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

/**
 @author Ilyas Almakaev
 Модуль для отображения контроллеров
 */

import UIKit

class UserFriendsListRouter: BaseRouter, UserFriendsListRouterInput {
    
    private var factory: UserInfoControllerFactory!
    
    init(controller: UIViewController, factory: UserInfoControllerFactory) {
        super.init(viewController: controller)
        self.factory = factory
    }
    
    func openFriendInfo(friendID: Int) {
        print("opent \(friendID)")
        guard let userInfoViewController = factory.controller(input: UserInfoInputDataModel(userID: friendID))?.viewController else { return }
        viewController.navigationController?.pushViewController(userInfoViewController, animated: true)
    }
}
