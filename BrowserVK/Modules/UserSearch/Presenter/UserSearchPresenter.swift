//
//  UserSearchAIUserSearchPresenter.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

class UserSearchPresenter: UserSearchModuleInput, UserSearchViewOutput, UserSearchInteractorOutput {
    
    weak var view: UserSearchViewInput!
    var interactor: UserSearchInteractorInput!
    var router: UserSearchRouterInput!
    
    func viewIsReady() {
 //       interactor.initVK()
    }
    
    func search(string: String) {
        resetSearch()
        interactor.loadSearchedContacts(name: string)
    }
    
    func resetSearch() {
        interactor.resetSearch()
    }
    
    func loadedSearchedContacts(contacts: [Contact]) {
        view.loadedSearchedContacts(contacts: contacts)
        view.updateTableView()
        view.stopAnimatingActivityIndicator()
        view.stopRefreshControl()
    }
    
    func openUserInfoViewController(navigationController: UINavigationController, id: Int) {
        router.openUserInfoViewController(navigationController: navigationController, userID: id)
    }
    
    func checkPagination(index: Int, arrayCount: Int) {
        if index == arrayCount - 1 {
            if interactor.hasMore {
                view.startAnimatingActivityIndicator()
                interactor.getNextContacts()
            }
        }
    }
}
