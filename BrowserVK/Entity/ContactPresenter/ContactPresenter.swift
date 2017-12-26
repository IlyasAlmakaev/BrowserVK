//
//  ContactPresenter.swift
//  BrowserVK
//
//  Created by Ильяс on 25.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

/**
 @author Ilyas Almakaev
 Модель контакта для presenter-слоя
 */

class ContactPresenter {
    
    /** id Контакта */
    var id: Int = 0
    /** Фамилия */
    var lastName: String = ""
    /** Имя */
    var firstName: String = ""
    /** Url-адрес картинки */
    var urlImage: URL?
    
    init() {}

    required init(contact: Contact?) {
        guard let contact = contact else { return }
        self.id = contact.id
        self.lastName = contact.lastName
        self.firstName = contact.firstName
        self.urlImage = URL(string: contact.urlImage) ?? nil
    }
}
