//
//  UserSearchAIUserSearchRouterInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

protocol UserSearchRouterInput: BaseRouterInput {
    func openUserInfoViewController(userID: Int)
}
