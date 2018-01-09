//
//  UserInfoAIUserInfoRouterInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation

protocol UserInfoRouterInput: BaseRouterInput {
    
    /**
     @author Ilyas Almakaev
     Метод показа ошибки при загрузке подробной информации о контакте
     
     @return Ошибка
     */
    
    func showErrorAlert(errorDescription: String) // REVIEW: Дублирование. В BaseRouterInput уже описано
}
