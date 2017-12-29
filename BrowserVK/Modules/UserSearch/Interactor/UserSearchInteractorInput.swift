//
//  AIUserSearchAIUserSearchInteractorInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation
import RxSwift

protocol UserSearchInteractorInput {
    
    /**
     @author Ilyas Almakaev
     Метод проверки авторизации в вк
     */
    
    func checkOnAuthorization()
    
    /**
     @author Ilyas Almakaev
     Метод загрузки списка контактов
     */
    
    func loadSearchedContacts(name: String)
    
    /**
     @author Ilyas Almakaev
     Метод для очистки поисковых данных
     */
    
    func resetSearch()
    
    /**
     @author Ilyas Almakaev
     Метод для загрузки данных для следующей страницы списка контактов
     */
    
    func getNextContacts()
    
    var hasMore: Bool { get }
    
    var contactsVariable: Variable<[Contact]> { get }
}
