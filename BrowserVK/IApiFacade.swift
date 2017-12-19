//
//  IApiFacade.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

protocol IApiFacade: class {
    func loadSearchedContacts(name: String)
    func loadUserInfo(userID: Int)
    func getNextContacts()
    func resetSearch()
}
