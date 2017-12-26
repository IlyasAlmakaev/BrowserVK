//
//  Contact.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

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

extension Contact: Refflectable {
    func toJSON() -> [String : AnyObject] {
        var d = [String : AnyObject]()
        d["id"] = id as AnyObject?
        d["last_name"] = lastName as AnyObject?
        d["first_name"] = firstName as AnyObject?
        d["photo_50"] = urlImage as AnyObject?
        
        return d
    }
}