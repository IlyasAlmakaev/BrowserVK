//
//  AIUserSearchAIUserSearchInteractorInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation
import RxSwift

protocol UserSearchInteractorInput {
    
    func loadSearchedContacts(name: String)
    
    func resetSearch()
    
    func getNextContacts()
    
    var hasMore: Bool { get set }
    
    var contactsVariable: Variable<[Contact]> { get set }
}
