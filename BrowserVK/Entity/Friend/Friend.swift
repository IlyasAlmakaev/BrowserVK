//
//  Friend.swift
//  BrowserVK
//
//  Created by Ильяс on 11.01.18.
//  Copyright © 2018 Ильяс. All rights reserved.
//

import Foundation

/**
 @author Ilyas Almakaev
 Модель друга выбранного контакта для interactor-слоя
 */

class Friend: Mappable {
    
    /** id Друга */
    var id: Int = 0
    /** Фамилия */
    var lastName: String?
    /** Имя */
    var firstName: String?
    /** Ссылка на картинку */
    var urlImage: String?
    
    init() {}
    
    required init?(map: AnyObject?) {
        guard let map = map as? [String: AnyObject], let id = map["id"] as? Int else { return nil }
        self.id = id
        self.lastName = map["last_name"] as? String
        self.firstName = map["first_name"] as? String
        self.urlImage = map["photo_50"] as? String
    }
}

extension Friend: Equatable {
    static func ==(lhs: Friend, rhs: Friend) -> Bool {
        return lhs.id == rhs.id && rhs.id == lhs.id
    }
}
