//
//  ContactDetailMapper.swift
//  BrowserVK
//
//  Created by Ильяс on 13.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift

/**
 @author Ilyas Almakaev
 Конвертер для модели детальной информации о контакте
 */

class ContactDetailMapper: Mapper<ContactDetail,RContactDetail> {
    
    override func mapTo(item: RContactDetail) -> ContactDetail? {
        let object = ContactDetail()
        object.id = item.id
        object.lastName = item.lastName
        object.firstName = item.firstName
        object.nickName = item.nickName
        object.screenname = item.screenname
        object.sex = item.sex
        object.relation = item.relation.value
        object.urlImageLarge = item.urlImageLarge
        
        return object
    }
    
    override func mapFrom(item: ContactDetail) -> RContactDetail? {
        let object = RContactDetail()
        object.id = item.id
        object.lastName = item.lastName
        object.firstName = item.firstName
        object.nickName = item.nickName
        object.screenname = item.screenname
        object.sex = item.sex
        object.relation.value = item.relation
        object.urlImageLarge = item.urlImageLarge
        
        return object
    }
    
    override func map(from json: AnyObject?) -> ContactDetail? {
        return nil
    }
}
