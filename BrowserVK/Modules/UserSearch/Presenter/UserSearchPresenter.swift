//
//  UserSearchAIUserSearchPresenter.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

class UserSearchPresenter: UserSearchModuleInput, UserSearchViewOutput, UserSearchInteractorOutput {
    
    weak var view: UserSearchViewInput!
    var interactor: UserSearchInteractorInput!
    var router: UserSearchRouterInput!
    var tableDatasource: AnyTableDataSource = AnyTableDataSource()
    
    func viewIsReady() {
        interactor.contactsVariable.asObservable().subscribe(onNext: { (contacts) in
            self.provideDataSource(contacts)
            self.view.stopAnimatingActivityIndicator()
            self.view.stopRefreshControl()
        }, onError: { (error) in
            print("error \(error)")
        }, onCompleted: {
            
        }) { 
            print("dispose")
        }
 //       interactor.contactsVariable.asObservable().subscribe( (contacts) in
            
        
//        )
  
    }
    
    func search(string: String) {
        resetSearch()
        interactor.loadSearchedContacts(name: string)
    }
    
    func resetSearch() {
        interactor.resetSearch()
    }
    
//    func loadedSearchedContacts(contacts: [Contact]) {
//        provideDataSource(contacts)
//        view.stopAnimatingActivityIndicator()
//        view.stopRefreshControl()
//    }
    
    func checkPagination(index: Int, arrayCount: Int) {
        if index == arrayCount - 1 {
            if interactor.hasMore {
                view.startAnimatingActivityIndicator()
                interactor.getNextContacts()
            }
        }
    }
    
    // Mark: TableView
    
    func provideDataSource(_ contactList: [Contact]) {
        tableDatasource.clear()
        let contactFactory: (Contact, UserSearchTableViewCell, Int, Int) -> UserSearchTableViewCell =
        { (item, cell, section, row) -> UserSearchTableViewCell in
            cell.contact = item
            return cell
        }
        let selectRowAction: ((Contact) -> Void) = { [weak self] (item) -> Void in
            self?.router.openUserInfoViewController(userID: item.id)
        }
        tableDatasource.registerSection(for: UserSearchTableViewCell.self, for: Contact.self, with: contactList, factory: contactFactory, selectAction: selectRowAction)
        view.provideTableDataSource(datasource: tableDatasource)
        view.updateTableView()
    }
}
