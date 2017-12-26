//
//  AbstractTableDataSource.swift
//  safesensor
//
//  Created by Anton Skorodumov on 06.07.17.
//  Copyright © 2017 E-Lite-Telecom. All rights reserved.
//

import UIKit

class AnyTableDataSource: NSObject {
    
    internal var section: Int = 0
    internal var builders: [AbstractSectionDataBuilder]!
    internal var scrollListener: ((Float, Float) -> Void)?
    
    override init() {
        super.init()
        builders = [AbstractSectionDataBuilder]()
    }
    
    public func registerSection<Data, Cell: UITableViewCell>(for cell: Cell.Type,
                                for dataType: Data.Type,
                                with data: [Data],
                                factory: @escaping (Data, Cell, Int, Int) -> Cell,
                                selectAction: ((Data) -> Void)?) {
        let builder = SectionDataBuilder<Data, Cell>(section: section,
                                                     data: data,
                                                     factory: factory,
                                                     selectAction: selectAction,
                                                     header: nil)
        builders.append(builder)
        section += 1
    }
    
    public func registerSection<Data, Cell: UITableViewCell>(for cell: Cell.Type,
                                with data: Data,
                                factory: @escaping (Data, Cell, Int, Int) -> Cell,
                                selectAction: ((Data) -> Void)?) {
        let builder = SectionDataBuilder<Data, Cell>(section: section,
                                                     data: [data],
                                                     factory: factory,
                                                     selectAction: selectAction,
                                                     header: nil)
        builders.append(builder)
        section += 1
    }
    
    public func registerSection<Data, Cell: UITableViewCell>(for cell: Cell.Type,
                                with data: [Data],
                                factory: @escaping (Data, Cell, Int, Int) -> Cell,
                                selectAction: ((Data) -> Void)?,
                                header: String?) {
        let builder = SectionDataBuilder<Data, Cell>(section: section,
                                                     data: data,
                                                     factory: factory,
                                                     selectAction: selectAction,
                                                     header: header)
        builders.append(builder)
        section += 1
    }
    
    public func register(scrollListener scroll: @escaping (Float, Float) -> Void ) {
        scrollListener = scroll
    }
    
    public func register(section: Int, height: CGFloat?) {
        guard section < builders.count else { return }
        let builderData: AbstractSectionDataBuilder = builders[section]
        builderData.set(height: height ?? UITableViewAutomaticDimension)
    }
    
    public func clear() {
        builders.forEach { (builder) in
            builder.clearData()
        }
        builders.removeAll()
        section = 0
    }
}

extension AnyTableDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return builders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let builderData: AbstractSectionDataBuilder = builders[section]
        return builderData.numberOfRowForSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let builderData: AbstractSectionDataBuilder = builders[indexPath.section]
        let cell = builderData.cellForRowFromTable(tableView: tableView, index: indexPath.row)
        var fr = cell.frame
        fr.size.width = tableView.frame.width
        cell.frame = fr
        return builderData.buildCellForRow(cell: cell, index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let builderData: AbstractSectionDataBuilder = builders[section]
        return builderData.titleForSection(index: section)
    }
}

extension AnyTableDataSource: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let builderData: AbstractSectionDataBuilder = builders[indexPath.section]
        builderData.selectRowForIndex(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let builderData: AbstractSectionDataBuilder = builders[indexPath.section]
        return builderData.heightForIndex(index: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let builderData: AbstractSectionDataBuilder = builders[indexPath.section]
        return builderData.heightForIndex(index: indexPath.section)
    }
    
}

extension AnyTableDataSource: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollListener?(Float(scrollView.contentOffset.x), Float(scrollView.contentOffset.y))
    }
}
