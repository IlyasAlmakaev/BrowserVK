//
//  RealmService.swift
//  BrowserVK
//
//  Created by Ильяс on 28.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import RealmSwift

/**
 @author Ilyas Almakaev
 Сервис по работе с Realm
 */

class RealmService {

    fileprivate var realm: Realm!
    
    init() {
        realm = try! Realm()
    }
    
    func write(object: Object?, successHandler: @escaping() -> Void) {
        guard let object = object else { return }
        realm.beginWrite()
        realm.add(object, update: true)
        try! realm.commitWrite()
        successHandler()
    }
    
    func read<T: Object>(objectID: Int) -> T {
        let object = realm.objects(T.self).filter("id = %@", objectID)
        guard let firstObject = object.first else { return T() }
        return firstObject
    }
    
    func deleteAll() {
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
    }
}
