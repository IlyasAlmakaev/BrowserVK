//
//  ContactDetail.swift
//  BrowserVK
//
//  Created by Ильяс on 13.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

/**
 @author Ilyas Almakaev
 Модель детальной информации о контакте для interactor-слоя
 */

class ContactDetail: Mappable {
    
    /** id Контакта */
    var id: Int = 0
    /** Фамилия */
    var lastName: String = ""
    /** Имя */
    var firstName: String = ""
    /** Отчество */
    var nickName: String = ""
    /** screenname */
    var screenname: String = ""
    /** Пол */
    var sex: Int = 0
    /** Семейное положение */
    var relation: Int?
    /** Ссылка на картинку */
    var urlImageLarge: String = ""
    
    init() {}
    
    required init?(map: AnyObject?) {
        guard let map = map as? [String: AnyObject] else { return nil }
        guard let id = map["id"] as? Int else { return nil }
        self.id = id
        self.lastName = map["last_name"] as! String
        self.firstName = map["first_name"] as! String
        self.nickName = map["nickname"] as! String
        self.screenname = map["screen_name"] as! String
        self.sex = map["sex"] as! Int
        self.relation = map["relation"] as? Int
        self.urlImageLarge = map["photo_200"] as! String
    }
}

extension ContactDetail: Equatable {
    static func ==(lhs: ContactDetail, rhs: ContactDetail) -> Bool {
        return lhs.id == rhs.id && rhs.id == lhs.id
    }
}
