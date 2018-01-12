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
        guard let id = item.id.value else { return ContactDetail() }
        object.id = id
        object.lastName = item.lastName
        object.firstName = item.firstName
        object.nickName = item.nickName
        object.screenname = item.screenname
        object.sex = item.sex.value
        object.relation = item.relation.value
        object.urlImageLarge = item.urlImageLarge
        
        return object
    }
    
    override func mapFrom(item: ContactDetail) -> RContactDetail? {
        let object = RContactDetail()
        object.id.value = item.id
        object.lastName = item.lastName
        object.firstName = item.firstName
        object.nickName = item.nickName
        object.screenname = item.screenname
        object.sex.value = item.sex
        object.relation.value = item.relation
        object.urlImageLarge = item.urlImageLarge
        
        return object
    }
    
    override func map(from json: AnyObject?) -> ContactDetail? {
        return nil
    }
}
