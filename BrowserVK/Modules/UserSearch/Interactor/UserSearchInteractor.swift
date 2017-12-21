//
//  AIUserSearchAIUserSearchInteractor.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//
import RxSwift
import RxCocoa

class UserSearchInteractor: UserSearchInteractorInput {
    
    weak var output: UserSearchInteractorOutput!
    var apiFacade: IApiFacade!
    var vkRepository: IVkRepository!
    var hasMore = false
    var countContacts = 0
    var currentName = ""
    var contactsVariable: Variable<[Contact]> = Variable([])
    
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
            
            self?.hasMore = hasMore
            self?.vkRepository.setSearchedContacts(objects: successArray, successHundler:  {
                
                let contacts = self?.vkRepository.getSearchedContacts()
                
                self?.contactsVariable.value = contacts!
                
//                contactsVariable.subscribe { contactList in
//                    print(contactList)
//                }
             //   contactsVariable = contacts

         //       self?.output.loadedSearchedContacts(contacts: contacts!)
            })
        })
    }
}
