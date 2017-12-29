//
//  IApiFacade.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

protocol IApiFacade: class {
    
    /**
     @author Ilyas Almakaev
     Метод получения списка контактов
     */
    
    func loadSearchedContacts(name: String, countContacts: Int, successHundler: @escaping (Array<Any>?) -> Void, errorHundler: @escaping (Error) -> Void)
    
    /**
     @author Ilyas Almakaev
     Метод получения детальной информации о выбранном контакте
     */
    
    func loadUserInfo(userID: Int, successHundler: @escaping (Any?) -> Void, errorHundler: @escaping (Error) -> Void)
    
    /**
     @author Ilyas Almakaev
     Метод проверки авторизации в вк
     */
    
    func checkOnAuthorization()
}
