//
//  AIUserSearchAIUserSearchInteractor.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//
import RxSwift

class UserSearchInteractor: UserSearchInteractorInput {
    
    weak var output: UserSearchInteractorOutput!
    var apiFacade: IApiFacade!
    var vkRepository: IVkRepository!
    var hasMore = false
    var contactsVariable: Variable<[Contact]> = Variable([])
    private var countContacts = 0
    private var currentName = ""
    
    init(apiFacade: IApiFacade, vkRepository: IVkRepository) {
        self.apiFacade = apiFacade
        self.vkRepository = vkRepository
    }
    
    func getNextContacts() {
        countContacts += 20
        loadContacts()
    }
    
    func resetSearch() {
        countContacts = 0
        apiFacade.resetSearch()
        vkRepository.deleteAll()
    }
    
    func loadSearchedContacts(name: String) {
        currentName = name
        loadContacts()
    }
    
    func loadContacts() {
        apiFacade.loadSearchedContacts(name: currentName, countContacts: countContacts, successHundler: { [weak self] (successArray, hasMore) in
            guard let strongSelf = self else { return }
            strongSelf.hasMore = hasMore
            strongSelf.vkRepository.setSearchedContacts(objects: successArray, successHundler:  {
                let contacts = strongSelf.vkRepository.getSearchedContacts()
                strongSelf.contactsVariable.value = contacts
                
            })
            }, errorHundler: { [weak self] (error) in
                guard let strongSelf = self else { return }
                strongSelf.output.showError(error)
                CocoaLumberjackService.error(error.localizedDescription)
                print(CocoaLumberjackService.stringLogs())
        })
    }
}
