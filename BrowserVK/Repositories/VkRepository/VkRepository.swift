//
//  VkRepository.swift
//  BrowserVK
//
//  Created by Ильяс on 13.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift

class VkRepository {
    
    var userSearchInteractor: UserSearchInteractorInput!
    var userInfoInteractor: UserInfoInteractorInput!
    fileprivate var realm: Realm!
    fileprivate var contactMapper = ContactMapper()
    fileprivate var contactDetailMapper = ContactDetailMapper()
    
    init() {
        realm = try! Realm()
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

extension VkRepository: IVkRepository {
    
    // MARK: UserSearchInteractorInput
    
    func setSearchedContacts(objects: Array<Any>?, successHundler: @escaping() -> Void) {
        guard let objects = objects else {
            return
        }
        
        realm.beginWrite()
        
        for object in objects {
            let contact = Contact(map: object as AnyObject)
            var rContact = RContact()
            rContact = contactMapper.mapFrom(item: contact!)!
            realm.add(rContact, update: true)
        }
  
        try! realm.commitWrite()

        successHundler()
    }
    
    func getSearchedContacts() -> [Contact] {
        var contacts = [Contact]()
        let objects = realm.objects(RContact.self)
        
        for object in objects {
            let contact = contactMapper.mapTo(item: object)
            contacts.append(contact!)
        }
        
        return contacts
    }
    
    // MARK: UserInfoInteractorInput
    
    func setSelectedContact(object: Any?, successHundler: @escaping(RContactDetail) -> Void) {
        guard let object = object else {
            return
        }

        realm.beginWrite()
        
        let contactDetail = ContactDetail(map: object as AnyObject)
        let rContactDetail = contactDetailMapper.mapFrom(item: contactDetail!)!
        
        realm.add(rContactDetail, update: true)
        
        try! realm.commitWrite()

        successHundler(rContactDetail)
    }
    
    func getSelectedContact(contact: RContactDetail) -> ContactDetail {
        var contactDetail = ContactDetail()
        let object = realm.objects(RContactDetail.self).filter("id = %@", contact.id)
        
        contactDetail = contactDetailMapper.mapTo(item: object.first!)!
        
        return contactDetail
    }
}
