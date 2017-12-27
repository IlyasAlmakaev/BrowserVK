//
//  Refflectable.swift
//  BrowserVK
//
//  Created by Ильяс on 13.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
// REVIEW: А нужно ли оно вообще в приложении?
protocol Refflectable {
    func toJSON() -> [String : AnyObject]
}
