//
//  AIUserInfoAIUserInfoInteractorInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation

protocol UserInfoInteractorInput {
    
    /**
     @author Ilyas Almakaev
     Метод запроса детальной информации о контакте по id-контакта
     */
    
    func loadUserInfo(userID: Int)
}
