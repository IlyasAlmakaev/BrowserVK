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
    
    var realmService: RealmService!
    fileprivate var contactDetailMapper = ContactDetailMapper()

    init(realmService: RealmService) {
        self.realmService = realmService
    }
   
    func deleteAll() {
        realmService.deleteAll()
    }
}

extension VkRepository: IVkRepository {
    
    func setSelectedContact(object: Any?, successHandler: @escaping(ContactDetail) -> Void) {
        guard let object = object, let contactDetail = ContactDetail(map: object as AnyObject) else { return }
        let rContactDetail = contactDetailMapper.mapFrom(item: contactDetail)
        realmService.write(object: rContactDetail, successHandler: { [weak self] in
            guard let strongSelf = self else { return }
            successHandler(strongSelf.getSelectedContact(contactID: contactDetail.id))
        })
    }
    
    func getSelectedContact(contactID: Int) -> ContactDetail {
        let contact: RContactDetail = realmService.read(objectID: contactID)
        guard let contactDetail = contactDetailMapper.mapTo(item: contact) else { return ContactDetail() }
        return contactDetail
    }
}
