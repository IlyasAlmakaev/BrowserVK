//
//  UserFriendsListAIUserFriendsListPresenter.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

class UserFriendsListPresenter: BasePresenter, UserFriendsListModuleInput, UserFriendsListViewOutput, UserFriendsListInteractorOutput {

    weak var view: UserFriendsListViewInput!
    var interactor: UserFriendsListInteractorInput!
    private var userID: Int
    
    init(userID: Int) {
        self.userID = userID
    }

    func viewIsReady() {
        interactor.loadUserFriendsList(userID: userID)
    }
    
    func loadedUserFriendsList(friendList: [Friend]) {
        let friendsPresenter = prepareFriendsPresenter(friends: friendList)
        view.loadedUserFriendsList(friendList: friendsPresenter)
    }
    
    func prepareFriendsPresenter(friends: [Friend]) -> [FriendPresenter] {
        var friendsPresenter: [FriendPresenter] = []
        for friend in friends {
            let friendPresenter = FriendPresenter(friend: friend)
            friendsPresenter.append(friendPresenter)
        }
        return friendsPresenter
    }
}
