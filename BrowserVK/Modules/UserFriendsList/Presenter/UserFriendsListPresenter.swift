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
    private var friendList: [FriendPresenter] = []
    private var userID: Int
    
    init(userID: Int) {
        self.userID = userID
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
    
    func getUserFriend(row: Int) -> FriendPresenter {
        return friendList[row]
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
