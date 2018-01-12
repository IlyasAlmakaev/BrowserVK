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
        if row >= friendList.count {
            return
        } else {
            let friend = friendList[row]
            userFriendListRouter.openFriendInfo(friendID: friend.id)
        }
    }
    
    override func showError(_ error: Error) {
        userFriendListRouter.showErrorAlert(errorDescription: error.localizedDescription)
    }
}
