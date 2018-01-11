//
//  AIUserFriendsListAIUserFriendsListInteractorInput.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import Foundation

protocol UserFriendsListInteractorInput {

    /**
     @author Ilyas Almakaev
     Метод запроса списка друзей контакта по id-контакту
     */
    
    func loadUserFriendsList(userID: Int)
}
