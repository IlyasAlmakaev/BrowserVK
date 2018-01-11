//
//  FriendPresenter.swift
//  BrowserVK
//
//  Created by Ильяс on 11.01.18.
//  Copyright © 2018 Ильяс. All rights reserved.
//

import Foundation

/**
 @author Ilyas Almakaev
 Модель друга выбранного контакта для presenter-слоя
 */

class FriendPresenter {
    
    /** id Контакта */
    var id: Int = 0
    /** Фамилия и имя */
    var fullName: String = ""
    /** Фамилия */
    var lastName: String = ""
    /** Имя */
    var firstName: String = ""
    /** Url-адрес картинки */
    var urlImage: URL?
    
    init() {}
    
    required init(friend: Friend?) {
        guard let friend = friend else { return }
        self.id = friend.id
        self.fullName = "\(friend.lastName) \(friend.firstName)"
        self.urlImage = URL(string: friend.urlImage) ?? nil
    }
}
