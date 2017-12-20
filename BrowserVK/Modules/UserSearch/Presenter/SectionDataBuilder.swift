//
//  TableCellDataBuilder.swift
//  safesensor
//
//  Created by Anton Skorodumov on 06.07.17.
//  Copyright © 2017 E-Lite-Telecom. All rights reserved.
//

import Foundation
import UIKit

class SectionDataBuilder<Data, Cell: UITableViewCell> {
    
    var section: Int!
    var header: String?
    var data: [Data]!
    var factory: ((Data, Cell, Int, Int) -> Cell)!
    var onSelectAction: ((Data) -> Void)?
    var cellHeight: CGFloat = UITableViewAutomaticDimension
    
    init(section: Int,
         data: [Data],
         factory: @escaping (Data, Cell, Int, Int) -> Cell,
         selectAction: ((Data) -> Void)?,
         header: String?) {
        self.section = section
        self.data = data
        self.factory = factory
        self.onSelectAction = selectAction
        self.header = header
    }
}

extension SectionDataBuilder: AbstractSectionDataBuilder {

    func numberOfRowForSection() -> Int {
        return data.count
    }
    
    func cellForRowFromTable(tableView: UITableView, index: Int) -> UITableViewCell {
        let indexPath = IndexPath(row: index, section: section)
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier(), for: indexPath) as! Cell
        return cell
    }
    
    func buildCellForRow(cell: UITableViewCell, index: Int) -> UITableViewCell {
        let item: Data = data[index]
        if let cell = cell as? Cell {
            return factory(item, cell, section, index)
        }
        return cell
    }
    
    func clearData() {
        data.removeAll()
    }
    
    func selectRowForIndex(index: Int) {
        let item: Data = data[index]
        onSelectAction?(item)
    }
    
    func titleForSection(index: Int) -> String? {
        return header
    }
    
    func heightForIndex(index: Int) -> CGFloat {
        return cellHeight
    }
    
    func set(height: CGFloat) {
        cellHeight = height
    }
    
}
