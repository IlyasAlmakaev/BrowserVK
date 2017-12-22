//
//  IApiFacade.swift
//  BrowserVK
//
//  Created by Ильяс on 18.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

protocol IApiFacade: class {
    func loadSearchedContacts(name: String, countContacts: Int, successHundler: @escaping (Array<Any>?, Bool) -> Void, errorHundler: @escaping (Error) -> Void)
    func loadUserInfo(userID: Int, successHundler: @escaping (Any?) -> Void, errorHundler: @escaping (Error) -> Void)
    func resetSearch()
}
