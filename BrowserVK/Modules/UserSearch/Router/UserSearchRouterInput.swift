//
//  UserSearchAIUserSearchRouterInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

protocol UserSearchRouterInput: BaseRouterInput {
    
    /**
     @author Ilyas Almakaev
     Метод показа UserInfoViewController
     */
    
    func openUserInfoViewController(userID: Int)
}
