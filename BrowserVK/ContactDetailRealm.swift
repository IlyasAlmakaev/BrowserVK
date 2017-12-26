//
//  ContactDetailRealm.swift
//  BrowserVK
//
//  Created by Ильяс on 13.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift

class RContactDetail: Object {
    
    /** id Контакта */
    dynamic var id: Int = 0
    /** Фамилия */
    dynamic var lastName: String = ""
    /** Имя */
    dynamic var firstName: String = ""
    /** Отчество */
    dynamic var nickName: String = ""
    /** screenname */
    dynamic var screenname: String = ""
    /** Пол */
    dynamic var sex: Int = 0
    /** Семейное положение */
    var relation = RealmOptional<Int>()
    /** Ссылка на картинку */
    dynamic var urlImageLarge: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}