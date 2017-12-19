//
//  Mapper.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

class Mapper<T: Mappable, Y> {
    
    func mapTo(item: Y) -> T? { return nil }
    
    func mapFrom(item: T) -> Y? { return nil }
    
    func map(from json: AnyObject?) -> T? { return nil }
}
