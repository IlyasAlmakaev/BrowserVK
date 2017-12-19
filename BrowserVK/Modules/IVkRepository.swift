//
//  IVkRepository.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

protocol IVkRepository: class {
    func setSearchedContacts(objects: Array<Any>?)
    func deleteAll()
    func setSelectedContact(object: Any?)
}
