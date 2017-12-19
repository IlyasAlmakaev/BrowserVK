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
        apiFacade.loadUserInfo(userID: userID)
    }
    
    func setUserInfo(object: Any?) {
        print("getUserInformation \(String(describing: object))")
        self.vkRepository.setSelectedContact(object: object)
    }
    
    func loadedUserInfo(info: ContactDetail) {
        print("getUserInformation \(info)")
        self.output.loadedUserInfo(info: info)
    }
}
