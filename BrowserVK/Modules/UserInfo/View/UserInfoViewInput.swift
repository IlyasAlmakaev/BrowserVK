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
     Setup initial state of the view
     */
    
    func setupInitialState()
    
    func loadedUserInfo(contact: ContactDetailPresenter)
}
