//
//  UserFriendsListAIUserFriendsListViewController.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class UserFriendsListViewController: UIViewController, UserFriendsListViewInput {

    var output: UserFriendsListViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: UserFriendsListViewInput
    func setupInitialState() {
        print("initializeUserFriend")
    }
}
