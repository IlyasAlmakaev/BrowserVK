//
//  UserInfoAIUserInfoPresenter.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

class UserInfoPresenter: UserInfoModuleInput, UserInfoViewOutput, UserInfoInteractorOutput {
    
    weak var view: UserInfoViewInput!
    var interactor: UserInfoInteractorInput!
    var router: UserInfoRouterInput!
    private var userID: Int 
    
    init(userID: Int) {
        self.userID = userID
    }
    
    func viewIsReady() {
        interactor.loadUserInfo(userID: userID)
    }
    
    func loadedUserInfo(info: ContactDetail) {
        let contactDetailPresenter = ContactDetailPresenter(contactDetail: info)
        view.loadedUserInfo(contact: contactDetailPresenter)
    }
    
    func showError(_ error: Error) { // REVIEW: Ошибки могут возникнуть везде. Лучше вынести в базовый класс
        router.showErrorAlert(errorDescription: error.localizedDescription)
    }
}
