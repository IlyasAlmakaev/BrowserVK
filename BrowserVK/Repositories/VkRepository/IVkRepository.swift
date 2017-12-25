//
//  IVkRepository.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

protocol IVkRepository: class {
    
    func setSearchedContacts(objects: Array<Any>?, successHundler: @escaping() -> Void)
    
    func getSearchedContacts() -> [Contact]
    
    func deleteAll()
    
    func setSelectedContact(object: Any?, successHundler: @escaping(RContactDetail) -> Void)
    
    func getSelectedContact(contact: RContactDetail) -> ContactDetail
}
