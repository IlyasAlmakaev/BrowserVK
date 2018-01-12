//
//  UserFriendsListAIUserFriendsListPresenter.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class UserFriendsListPresenter: BasePresenter, UserFriendsListModuleInput, UserFriendsListViewOutput, UserFriendsListInteractorOutput {

    weak var view: UserFriendsListViewInput!
    var interactor: UserFriendsListInteractorInput!
    var userFriendListRouter: UserFriendsListRouter!
    private var friendList: [FriendPresenter] = []
    private var userID: Int
    
    init(userID: Int, router: UserFriendsListRouter) {
        self.userID = userID
        userFriendListRouter = router
    }

    func viewIsReady() {
        interactor.loadUserFriendsList(userID: userID)
    }
    
    func loadedUserFriendsList(friendList: [Friend]) {
        self.friendList = prepareFriendsPresenter(friends: friendList)
        view.reloadCollectionView()
    }
    
    func getUserFriendsListCount() -> Int {
        return friendList.count
    }
    
    func getUserFriend(row: Int) -> FriendPresenter? {
        if row >= friendList.count {
            return nil
        } else {
            return friendList[row]
        }
    }
    
    func prepareFriendsPresenter(friends: [Friend]) -> [FriendPresenter] {
        var friendsPresenter: [FriendPresenter] = []
        for friend in friends {
            let friendPresenter = FriendPresenter(friend: friend)
            friendsPresenter.append(friendPresenter)
        }
        return friendsPresenter
    }
    
    func openFriendInfo(row: Int) {
        if row < friendList.count {
            let friend = friendList[row]
            userFriendListRouter.openFriendInfo(friendID: friend.id)
        }
    }
    
    func sizeCell(row: Int) -> CGSize {
        if row >= friendList.count {
            return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: 60.0, height: 60.0)
        }
    }
    
    override func showError(_ error: Error) {
        userFriendListRouter.showErrorAlert(errorDescription: error.localizedDescription)
    }
}
