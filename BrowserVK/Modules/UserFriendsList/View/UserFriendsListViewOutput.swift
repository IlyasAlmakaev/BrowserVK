//
//  UserFriendsListAIUserFriendsListViewOutput.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

protocol UserFriendsListViewOutput {

    /**
     @author Ilyas Almakaev
     Метод сообщает presenter'y что view загрузилась
     */

    func viewIsReady()
    
    /**
     @author Ilyas Almakaev
     Метод возвращает общее количество друзей выбранного контакта
     
     return Количество друзей
     */
    
    func getUserFriendsListCount() -> Int
    
    /**
     @author Ilyas Almakaev
     Метод друга выбранного контакта
     
     return Друг выбранного контакта
     */
    
    func getUserFriend(row: Int) -> FriendPresenter
}
