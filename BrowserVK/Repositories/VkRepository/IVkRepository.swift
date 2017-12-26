//
//  IVkRepository.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

protocol IVkRepository: class {
    
    /**
     @author Ilyas Almakaev
     Метод сохранения списка контактов
     */
    
    func setSearchedContacts(objects: Array<Any>?, successHundler: @escaping() -> Void)
    
    /**
     @author Ilyas Almakaev
     Метод возвращает список контактов
     
     @return Контакты
     */
    
    func getSearchedContacts() -> [Contact]
    
    /**
     @author Ilyas Almakaev
     Метод стирает базу данных контактов
     */
    
    func deleteAll()
    
    /**
     @author Ilyas Almakaev
     Метод сохранения списка подробной информации о контакте
     */
    
    func setSelectedContact(object: Any?, successHundler: @escaping(RContactDetail) -> Void)
    
    /**
     @author Ilyas Almakaev
     Метод возвращает детальную информацию о контакте
     
     @return Детальная информация о контакте
     */
    
    func getSelectedContact(contact: RContactDetail) -> ContactDetail
}
