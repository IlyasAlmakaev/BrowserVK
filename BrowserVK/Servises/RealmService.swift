//
//  RealmService.swift
//  BrowserVK
//
//  Created by Ильяс on 28.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    fileprivate var realm: Realm!
    
    init() {
        realm = try! Realm()
    }
    
    func deleteAll() {
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
    }
    
    
  //  func write
}
