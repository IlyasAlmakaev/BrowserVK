//
//  AIUserSearchAIUserSearchInteractorOutput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation

protocol UserSearchInteractorOutput: class {
    
    /**
     @author Ilyas Almakaev
     Метод показа ошибки при загрузке контактов
     
     @return Ошибка
     */
    
    func showError(_ error: Error)
}
