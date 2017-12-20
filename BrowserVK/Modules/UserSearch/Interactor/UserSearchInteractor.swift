//
//  AIUserSearchAIUserSearchInteractor.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//


class UserSearchInteractor: UserSearchInteractorInput {
    
    weak var output: UserSearchInteractorOutput!
    var apiFacade: IApiFacade!
    var vkRepository: IVkRepository!
    var hasMore = false
    
    init(apiFacade: IApiFacade, vkRepository: IVkRepository) {
        self.apiFacade = apiFacade
        self.vkRepository = vkRepository
    }
    
    func getNextContacts() {
        apiFacade.getNextContacts()
    }
    
    func resetSearch() {
        apiFacade.resetSearch()
        vkRepository.deleteAll()
    }
    
    func loadSearchedContacts(name: String) {
        
        apiFacade.loadSearchedContacts(name: name, successHundler: { [weak self] (successArray) in

            self?.vkRepository.setSearchedContacts(objects: successArray, successHundler:  {
                
                let contacts = self?.vkRepository.getSearchedContacts()
                self?.output.loadedSearchedContacts(contacts: contacts!)
            })
        })
    }
    
//    func setSearchedContacts(objects: Array<Any>?) {
//        vkRepository.setSearchedContacts(objects: objects, successHundler:  {
//            
//        })
//    }
    
//    func loadedSearchedContacts(contacts: [Contact]) {
//        
//    }
    
//    func initVK() {
//        apiFacade.initVK()
//    }
}
