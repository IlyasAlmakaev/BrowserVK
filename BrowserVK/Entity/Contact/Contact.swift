//
//  Contact.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

/**
 @author Ilyas Almakaev
 Модель контакта для interactor-слоя
 */

class Contact: Mappable {
    
    /** id Контакта */
    var id: Int = 0
    /** Фамилия */
    var lastName: String = ""
    /** Имя */
    var firstName: String = ""
    /** Ссылка на картинку */
    var urlImage: String = ""
    
    init() {}
    
    required init?(map: AnyObject?) {
        guard let map = map as? [String: AnyObject] else { return nil }
        guard let id = map["id"] as? Int else { return nil }
        self.id = id
        self.lastName = map["last_name"] as! String
        self.firstName = map["first_name"] as! String
        self.urlImage = map["photo_50"] as! String
    }
}

extension Contact: Equatable {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id && rhs.id == lhs.id
    }
}
