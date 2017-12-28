//
//  UserSearchAIUserSearchRouter.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

class UserSearchRouter: BaseRouter, UserSearchRouterInput {
    
    /**
     @author Ilyas Almakaev
     Модуль для отображения контроллеров
     */

    private var factory: UserInfoControllerFactory! 
    
    init(controller: UIViewController, factory: UserInfoControllerFactory) {
        super.init(viewController: controller)
        self.factory = factory
    }
    
    func openUserInfoViewController(userID: Int) {
        guard let userInfoViewController = factory.controller(input: UserInfoInputDataModel(userID: userID))?.viewController else { return }
        viewController.navigationController?.pushViewController(userInfoViewController, animated: true)
    }
}
