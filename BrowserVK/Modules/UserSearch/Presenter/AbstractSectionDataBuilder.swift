//
//  Abst.swift
//  safesensor
//
//  Created by Anton Skorodumov on 06.07.17.
//  Copyright © 2017 E-Lite-Telecom. All rights reserved.
//

import Foundation
import UIKit

protocol AbstractSectionDataBuilder {
    
    func numberOfRowForSection() -> Int
    func cellForRowFromTable(tableView: UITableView, index: Int) -> UITableViewCell
    func buildCellForRow(cell: UITableViewCell, index: Int) -> UITableViewCell
    func clearData()
    func selectRowForIndex(index: Int)
    func titleForSection(index: Int) -> String?
    func heightForIndex(index: Int) -> CGFloat
    func set(height: CGFloat)
}
