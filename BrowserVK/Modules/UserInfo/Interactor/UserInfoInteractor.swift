//
//  AIUserInfoAIUserInfoInteractor.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

class UserInfoInteractor: UserInfoInteractorInput {

    weak var output: UserInfoInteractorOutput!
    var apiFacade: IApiFacade!
    var vkRepository: IVkRepository!
    
    init(apiFacade: IApiFacade, vkRepository: IVkRepository) {
        self.apiFacade = apiFacade
        self.vkRepository = vkRepository
    }
    
    func loadUserInfo(userID: Int) {
        
        apiFacade.loadUserInfo(userID: userID, successHundler: { [weak self] (successObject) in
            
            self?.vkRepository.setSelectedContact(object: successObject, successHundler: { (rContactDetail) in
                
                let contact = self?.vkRepository.getSelectedContact(contact: rContactDetail)
                self?.output.loadedUserInfo(info: contact!)
            })
        })
    }
}
