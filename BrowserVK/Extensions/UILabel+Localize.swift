//
//  UILabel+Localize.swift
//  BrowserVK
//
//  Created by Ильяс on 29.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit

class LocalizedLabel : UILabel {
    override func awakeFromNib() {
        if let text = text {
            self.text = NSLocalizedString(text, comment: "")
        }
    }
}
