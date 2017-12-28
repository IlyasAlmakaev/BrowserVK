//
//  IRealmService.swift
//  BrowserVK
//
//  Created by Ильяс on 28.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

protocol IRealmService: class {
    
    /**
     @author Ilyas Almakaev
     Метод записи подробной информации о контакте в Realm
     */
    
    func write(contact: ContactDetail?, successHandler: @escaping() -> Void)

    /**
     @author Ilyas Almakaev
     Метод получения подробной информации о контакте из Realm
     
     @return Подробная информация о контакте
     */
    
    func read(contactID: Int) -> ContactDetail
    
    /**
     @author Ilyas Almakaev
     Метод стирает базу данных контактов
     */
    
    func deleteAll()
}
