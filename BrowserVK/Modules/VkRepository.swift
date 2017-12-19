//
//  VkRepository.swift
//  BrowserVK
//
//  Created by Ильяс on 13.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class VkRepository {
    
    fileprivate var realm: Realm!
    var contactMapper = ContactMapper()
    var contactDetailMapper = ContactDetailMapper()
    var userSearchInteractor: UserSearchInteractorInput!
    var userInfoInteractor: UserInfoInteractorInput!
    
    init() {
 //       Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
        realm = try! Realm()
//        try! realm.write {
//            realm.deleteAll()
//        }
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

    func getSelectedContact(contact: RContactDetail) -> ContactDetail {
        
        var contactDetail = ContactDetail()
        let object = realm.objects(RContactDetail.self).filter("id = %@", contact.id)
        
        contactDetail = contactDetailMapper.mapTo(item: object.first!)!

        return contactDetail
    }
}

extension VkRepository: IVkRepository {
    // MARK: UserSearchInteractorInput
    
    func setSearchedContacts(objects: Array<Any>?) {
        
        guard let objects = objects else {
            return
        }
        
        realm.beginWrite()
        let convertDeletedContact = Contact(map: objects[0] as AnyObject)
        let deletedContact = contactMapper.mapFrom(item: convertDeletedContact!)!
        
        //        var cont = [Contact]()
        
        for object in objects   {
            
            let contact = Contact(map: object as AnyObject)
            
            var rContact = RContact()
            rContact = contactMapper.mapFrom(item: contact!)!
            //            cont.append(contact!)
            realm.add(rContact, update: true)
            
            print("firstCheck -- \(rContact)")
            
        }
  
        try! realm.commitWrite()
        
        deleteContact(contact: deletedContact)
        //      deleteAll()
        
        self.userSearchInteractor.loadedSearchedContacts(contacts: getSearchedContacts())
        
        //        if cont == getSearchedContacts() {
        //            print("comparableToArrays")
        //        }
        
    }
    
    // MARK: UserInfoInteractorInput
    
    func setSelectedContact(object: Any?) {
        
        guard let object = object else {
            return
        }
        print("userInfromationObject \(object)")
        realm.beginWrite()
        
        let contactDetail = ContactDetail(map: object as AnyObject)
        let rContactDetail = contactDetailMapper.mapFrom(item: contactDetail!)!
        
        realm.add(rContactDetail, update: true)
        
        try! realm.commitWrite()
        
        self.userInfoInteractor.loadedUserInfo(info: getSelectedContact(contact: rContactDetail))
    }
}
