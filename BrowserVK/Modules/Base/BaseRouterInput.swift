//
//  BaseRouterInput.swift
//  BrowserVK
//
//  Created by Ильяс on 22.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

protocol BaseRouterInput {
    
    /**
     @author Ilyas Almakaev
     Метод показа ошибки при загрузке данных
     
     @return Ошибка
     */
    
    func showErrorAlert(errorDescription: String)
}
