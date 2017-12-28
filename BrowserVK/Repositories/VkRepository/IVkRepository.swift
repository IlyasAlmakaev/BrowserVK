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
     Метод возвращает контакты
     
     @return Контакты
     */
    
    func getSearchedContacts(objects: Array<Any>?) -> [Contact]
    
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
