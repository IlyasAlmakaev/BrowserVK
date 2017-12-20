//
//  UserSearchAIUserSearchRouter.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

class UserSearchRouter: UserSearchRouterInput {

    var userSearchViewController: UIViewController!
    var factory: UserInfoControllerFactory!
    
    init(controller: UIViewController, factory: UserInfoControllerFactory) {
        userSearchViewController = controller
        self.factory = factory
    }
    
    func openUserInfoViewController(userID: Int) {
        guard let userInfoViewController = factory.controller(input: UserInfoInputDataModel(userID: userID))?.viewController else { return }
        userSearchViewController.navigationController?.pushViewController(userInfoViewController, animated: true)
    }
}
