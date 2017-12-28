//
//  VkRepository.swift
//  BrowserVK
//
//  Created by Ильяс on 13.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

/**
 @author Ilyas Almakaev
 Репозитория для сохранения данных о контакте в Realm
 */

class VkRepository {
    
    var userSearchInteractor: UserSearchInteractorInput!
    var userInfoInteractor: UserInfoInteractorInput!
    var realmService: RealmService!
    fileprivate var contactDetailMapper = ContactDetailMapper()
    //TODO: использовать ли swinjet, если да, то как инициализировать?
    init() {
        realmService = RealmService()
    }
   
    func deleteAll() {
        realmService.deleteAll()
    }
}

extension VkRepository: IVkRepository {
    
    func getSearchedContacts(objects: Array<Any>?) -> [Contact] {
        guard let objects = objects else { return [] }
        var contacts: [Contact] = []
        for object in objects {
            guard let contact = Contact(map: object as AnyObject) else { return [] }
            contacts.append(contact)
        }
        
        return contacts
    }
    
    func setSelectedContact(object: Any?, successHandler: @escaping(ContactDetail) -> Void) {
        guard let object = object else { return }
        let contactDetail = ContactDetail(map: object as AnyObject)
        realmService.write(contact: contactDetail, successHandler: { [weak self] in
            guard let strongSelf = self, let contactDetail = contactDetail else { return }
            successHandler(strongSelf.getSelectedContact(contactID: contactDetail.id))
        })
    }
    
    func getSelectedContact(contactID: Int) -> ContactDetail { 
        return realmService.read(contactID: contactID)
    }
}
