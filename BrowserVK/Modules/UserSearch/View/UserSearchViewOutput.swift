//
//  UserSearchAIUserSearchViewOutput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

@objc protocol UserSearchViewOutput {

    /**
     @author Ilyas Almakaev
     Метод сообщает presenter'y что view загрузилась
     */

    func viewIsReady()
    
    /**
     @author Ilyas Almakaev
     Метод для очистки поисковых данных
     */
    
    func resetSearch()
    
    /**
     @author Ilyas Almakaev
     Метод для поиска контакта
     */
    
    func search(string: String)
    
    /**
     @author Ilyas Almakaev
     Метод для поиска контакта при RefreshControl
     */
    
    func searchWithRefreshControl()
    
    /**
     @author Ilyas Almakaev
     Метод для проверки на событие пролистывание таблицы вниз
     */
    
    func checkPagination(index: Int, arrayCount: Int)
}
