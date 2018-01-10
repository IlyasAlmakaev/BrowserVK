//
//  UserSearchAIUserSearchViewInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

protocol UserSearchViewInput: class {
    
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
     Метод работы индикаторов загрузки
     */
    
    func animateLoadingIndicators(isLoad: Bool)
    
    var refreshControl: UIRefreshControl { get }
}
