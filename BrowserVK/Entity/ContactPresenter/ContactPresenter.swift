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
    /** Фамилия и имя */
    var fullName: String = ""
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
        self.fullName = "\(contact.lastName) \(contact.firstName)"
        self.urlImage = URL(string: contact.urlImage) ?? nil
    }
}
