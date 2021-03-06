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
        output.loadedUserInfo(info: vkRepository.getSelectedContact(contactID: userID))
        apiFacade.loadUserInfo(userID: userID, successHundler: { [weak self] (successObject) in
            self?.setSelectedContact(object: successObject)
            }, errorHundler: { [weak self] (error) in
                self?.output.showError(error)
                CocoaLumberjackService.error(error.localizedDescription)
        })
    }
    
    func setSelectedContact(object: Any?) {
        vkRepository.setSelectedContact(object: object,
                                        successHandler: { [weak self] (rContactDetail) in
                                            guard let strongSelf = self else { return }
                                            let contact = strongSelf.vkRepository.getSelectedContact(contactID: rContactDetail.id)
                                            strongSelf.output.loadedUserInfo(info: contact)
        })
    }
}
