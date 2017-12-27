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
            // REVIEW: Перед запросом отображать данные из кэша
            self?.vkRepository.setSelectedContact(object: successObject,
                                                  successHundler: { (rContactDetail) in // REVIEW: [weak self]
                guard let strongSelf = self else { return }
                let contact = strongSelf.vkRepository.getSelectedContact(contact: rContactDetail)
                strongSelf.output.loadedUserInfo(info: contact)
            })
            }, errorHundler: { [weak self] (error) in
                guard let strongSelf = self else { return } // REVIEW: не обязательно
                strongSelf.output.showError(error) // REVIEW: Можно оставить self?.
                CocoaLumberjackService.error(error.localizedDescription)
                print(CocoaLumberjackService.stringLogs())
        })
    }
}
