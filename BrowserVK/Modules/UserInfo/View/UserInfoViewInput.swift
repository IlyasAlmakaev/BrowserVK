//
//  UserInfoAIUserInfoViewInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

protocol UserInfoViewInput: class {
    
    /**
     @author Ilyas Almakaev
     Метод инициализации view
     */
    
    func setupInitialState()
    
    /**
     @author Ilyas Almakaev
     Метод принимает детальную информацию о выбранном контакте
     */
    
    func loadedUserInfo(contact: ContactDetailPresenter)
}
