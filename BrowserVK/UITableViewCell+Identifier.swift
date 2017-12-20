//
//  UITableViewCell+Identifier.swift
//  BrowserVK
//
//  Created by Ильяс on 20.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static func identifier() -> String {
        return String(describing: self.self)
    }
    
}
