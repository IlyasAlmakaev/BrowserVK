//
//  RealmService.swift
//  BrowserVK
//
//  Created by Ильяс on 28.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift

/**
 @author Ilyas Almakaev
 Сервис по работе с Realm
 */

class RealmService {

    fileprivate var realm: Realm!
    fileprivate var contactDetailMapper = ContactDetailMapper()
    
    init() {
        realm = try! Realm()
    }
    
    func write(contact: ContactDetail?, successHandler: @escaping() -> Void) {
        guard let contact = contact else { return }
        guard let rContactDetail = contactDetailMapper.mapFrom(item: contact) else { return }
        realm.beginWrite()
        realm.add(rContactDetail, update: true)
        try! realm.commitWrite()
        successHandler()
    }
    
    func read(contactID: Int) -> ContactDetail {
        let contact = realm.objects(RContactDetail.self).filter("id = %@", contactID)
        guard let firstObject = contact.first, let contactDetail = contactDetailMapper.mapTo(item: firstObject) else { return ContactDetail() }
        return contactDetail
    }
    
    func deleteAll() {
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
    }
    
    func deleteContact(contact: RContact) {
        realm.beginWrite()
        let objectsToDelete = realm.objects(RContact.self).filter("id = %@", contact.id)
        realm.delete(objectsToDelete)
        try! realm.commitWrite()
    }
}
