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
    var hasMore = false
    var contactsVariable: Variable<[Contact]> = Variable([])
    private var apiFacade: IApiFacade!
    private var vkRepository: IVkRepository!
    private var countContacts = 0
    private var currentName = ""
    private var searchResults: [Contact] = [] // REVIEW: Any? Мы же точно знаем, с какими моделями работаем в этом классе
    
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
        searchResults = []
        vkRepository.deleteAll()
    }
    
    func loadSearchedContacts(name: String) {
        currentName = name
        loadContacts()
    }
    
    func loadContacts() { 
        apiFacade.loadSearchedContacts(name: currentName,
                                       countContacts: countContacts,
                                       successHundler: { [weak self] (successArray) in
                                        guard let strongSelf = self, let successArray = successArray else { return }
                                        if successArray.count == 20 {
                                            strongSelf.hasMore = true
                                        }
                                        strongSelf.searchResults += successArray
                                        strongSelf.contactsVariable.value = strongSelf.searchResults
            }, errorHundler: { [weak self] (error) in
                self?.output.showError(error) 
                CocoaLumberjackService.error(error.localizedDescription)
        })
    }
}
