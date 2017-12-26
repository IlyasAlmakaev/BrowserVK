//
//  ContactRealm.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift

/**
 @author Ilyas Almakaev
 Модель контакта для сохранения в Realm
 */

class RContact: Object {
    
    /** id Контакта */
    dynamic var id: Int = 0
    /** Фамилия */
    dynamic var lastName: String = ""
    /** Имя */
    dynamic var firstName: String = ""
    /** Ссылка на картинку */
    dynamic var urlImage: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
