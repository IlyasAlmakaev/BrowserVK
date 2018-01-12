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
        migrate()
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
    
    func migrate() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
    }
}
