//
//  AIUserFriendsListAIUserFriendsListInteractorOutput.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import Foundation

protocol UserFriendsListInteractorOutput: class {
    
    /**
     @author Ilyas Almakaev
     Метод загрузки списка друзей выбранного контакта
     */

    func loadedUserFriendsList(friendList: [Friend])
    
    /**
     @author Ilyas Almakaev
     Метод показа ошибки при загрузке списка друзей выбранного контакта
     */
    
    func showError(_ error: Error)
}
