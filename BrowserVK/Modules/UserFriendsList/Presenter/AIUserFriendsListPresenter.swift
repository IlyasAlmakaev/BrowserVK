//
//  UserFriendsListAIUserFriendsListPresenter.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

class UserFriendsListPresenter: UserFriendsListModuleInput, UserFriendsListViewOutput, UserFriendsListInteractorOutput {

    weak var view: UserFriendsListViewInput!
    var interactor: UserFriendsListInteractorInput!
    var router: UserFriendsListRouterInput!
    private var userID: Int
    
    init(userID: Int) {
        self.userID = userID
    }

    func viewIsReady() {

    }
}
