//
//  UserSearchAIUserSearchViewInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

protocol UserSearchViewInput: class {

    /**
        @author Ilyas Almakaev
        Метод инициализации view
    */
    
    func setupInitialState()
    
    /**
     @author Anton Skorodumov
     Метод отображения таблицы и его компонентов
     */
    
    func provideTableDataSource(datasource: AnyTableDataSource)
    
    /**
     @author Ilyas Almakaev
     Метод обновления таблицы
     */
    
    func updateTableView()
    
    /**
     @author Ilyas Almakaev
     Метод принимает загруженый список контактов
     */
    
    func loadedSearchedContacts(contacts: [Contact])
    
    /**
     @author Ilyas Almakaev
     Метод отображения анимации загрузочного индикатора
     */
    
    func startAnimatingActivityIndicator()
    
    /**
     @author Ilyas Almakaev
     Метод скрытия анимации загрузочного индикатора
     */
    
    func stopAnimatingActivityIndicator()
    
    /**
     @author Ilyas Almakaev
     Метод скрытия refreshControl
     */
    
    func stopRefreshControl()
}
