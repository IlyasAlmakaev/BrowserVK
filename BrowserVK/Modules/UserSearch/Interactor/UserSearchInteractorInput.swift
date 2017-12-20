//
//  AIUserSearchAIUserSearchInteractorInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation

protocol UserSearchInteractorInput {
    
    func loadSearchedContacts(name: String)
    
    func resetSearch()
    
    func getNextContacts()
    
    var hasMore: Bool { get set }
}
