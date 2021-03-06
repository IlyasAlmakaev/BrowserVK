//
//  UserInfoAIUserInfoPresenter.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

class UserInfoPresenter: BasePresenter, UserInfoModuleInput, UserInfoViewOutput, UserInfoInteractorOutput {
    
    weak var view: UserInfoViewInput!
    var interactor: UserInfoInteractorInput!
    var userFriendsListModule: UserFriendsListModuleInput!
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
}
