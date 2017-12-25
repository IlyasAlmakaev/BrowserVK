//
//  UITableView+Register.swift
//  BrowserVK
//
//  Created by Ильяс on 20.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(cell: UITableViewCell.Type) {
        register(UINib(nibName: cell.identifier(), bundle: nil), forCellReuseIdentifier: cell.identifier())
    }
    
    func registerHeight(cell: UITableViewCell.Type) {
        guard let cell = dequeueReusableCell(withIdentifier: cell.identifier()) else { return }
        estimatedRowHeight = cell.frame.height
        rowHeight = UITableViewAutomaticDimension
    }
    
}
