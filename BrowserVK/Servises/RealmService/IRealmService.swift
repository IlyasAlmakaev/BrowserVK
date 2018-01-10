//
//  IRealmService.swift
//  BrowserVK
//
//  Created by Ильяс on 28.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift

protocol IRealmService: class {
    
    /**
     @author Ilyas Almakaev
     Метод записи в Realm
     */
    
    func write(contact: Object?, successHandler: @escaping() -> Void)

    /**
     @author Ilyas Almakaev
     Метод получения данных из Realm
     
     @return Подробная информация о контакте
     */
    
    func read<T: Object>(objectID: Int) -> T
    
    /**
     @author Ilyas Almakaev
     Метод стирает базу данных контактов
     */
    
    func deleteAll()
}
