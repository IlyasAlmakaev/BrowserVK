//
//  VkRepository.swift
//  BrowserVK
//
//  Created by Ильяс on 13.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift // REVIEW: Вынест и работу с Realm в отдельный сервис

/**
 @author Ilyas Almakaev
 Репозитория для сохранения данных о контакте в Realm
 */

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
    
    func getSearchedContacts(objects: Array<Any>?) -> [Contact] {
        guard let objects = objects else { return [Contact()] }
        var contacts: [Contact] = []
        for object in objects {
            guard let contact = Contact(map: object as AnyObject) else { return [Contact()] }
            contacts.append(contact)
        }
        
        return contacts
    }
    
    func setSelectedContact(object: Any?, successHundler: @escaping(RContactDetail) -> Void) { // REVIEW: Модели Realm не должны выходить за пределы репозитория/сервиса
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
    
    func getSelectedContact(contact: RContactDetail) -> ContactDetail { // REVIEW: Откуда interactor знает Realm-модель? Правильнее сразу передавать id
        var contactDetail = ContactDetail()
        let object = realm.objects(RContactDetail.self).filter("id = %@", contact.id)
        contactDetail = contactDetailMapper.mapTo(item: object.first!)! // REVIEW: Надо проверять опционалы, а то неменуем краш
        
        return contactDetail
    }
}
