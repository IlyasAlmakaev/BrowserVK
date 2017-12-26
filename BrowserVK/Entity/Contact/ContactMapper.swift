//
//  ContactMapper.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift

class ContactMapper: Mapper<Contact,RContact> {
    
    override func mapTo(item: RContact) -> Contact? {
        let object = Contact()
        object.id = item.id
        object.lastName = item.lastName
        object.firstName = item.firstName
        object.urlImage = item.urlImage
        
        return object
    }
    
    override func mapFrom(item: Contact) -> RContact? {
        let object = RContact()
        object.id = item.id
        object.lastName = item.lastName
        object.firstName = item.firstName
        object.urlImage = item.urlImage
        
        return object
    }
    
    override func map(from json: AnyObject?) -> Contact? {
        return nil
    }
}
