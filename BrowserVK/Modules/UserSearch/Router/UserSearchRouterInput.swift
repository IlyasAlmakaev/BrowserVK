//
//  UserSearchAIUserSearchRouterInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation
import UIKit

protocol UserSearchRouterInput {
    func openUserInfoViewController(navigationController: UINavigationController, userID: Int)
}
