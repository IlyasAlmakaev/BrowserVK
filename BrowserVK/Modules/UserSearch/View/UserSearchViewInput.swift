//
//  UserSearchAIUserSearchViewInput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

protocol UserSearchViewInput: class {

    /**
        @author Ilyas
        Setup initial state of the view
    */
    
    func setupInitialState()
    
    
    func provideTableDataSource(datasource: AnyTableDataSource)
    
    
    func updateTableView()
    
    
    func loadedSearchedContacts(contacts: [Contact])
    
    
    func startAnimatingActivityIndicator()
    
    
    func stopAnimatingActivityIndicator()
    
    
    func stopRefreshControl()
}
