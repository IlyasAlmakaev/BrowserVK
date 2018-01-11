//
//  UserFriendsListAIUserFriendsListViewInput.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

protocol UserFriendsListViewInput: class {

    /**
        @author Ilyas
        Setup initial state of the view
    */

    func setupInitialState()
    
    /**
     @author Ilyas Almakaev
     Метод принимает детальную список друзей выбранного контакта
     */
    
    func loadedUserFriendsList(friendList: [FriendPresenter])
}
