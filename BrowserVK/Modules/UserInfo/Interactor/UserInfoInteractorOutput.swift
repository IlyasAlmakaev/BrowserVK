//
//  AIUserInfoAIUserInfoInteractorOutput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation

protocol UserInfoInteractorOutput: class {
    
    /**
     @author Ilyas Almakaev
     Метод загрузки детальной информации о контакте
     
     @return Детальная информация о контакте
     */
    
    func loadedUserInfo(info: ContactDetail)
    
    /**
     @author Ilyas Almakaev
     Метод показа ошибки при загрузке детальной информации о контакте
     
     @return Ошибка
     */
    
    func showError(_ error: Error)
}
