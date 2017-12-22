//
//  UserSearchAIUserSearchPresenter.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import RxSwift

class UserSearchPresenter: UserSearchModuleInput, UserSearchViewOutput, UserSearchInteractorOutput {
    
    weak var view: UserSearchViewInput!
    var interactor: UserSearchInteractorInput!
    var router: UserSearchRouterInput!
    var tableDatasource: AnyTableDataSource = AnyTableDataSource()
    var disposedBag: DisposeBag = DisposeBag()

    
    func viewIsReady() {
        interactor.contactsVariable.asObservable().subscribe(onNext: { (contacts) in
            self.provideDataSource(contacts)
            self.view.stopAnimatingActivityIndicator()
            self.view.stopRefreshControl()
        }).addDisposableTo(disposedBag)
    }
    
    func search(string: String) {
        resetSearch()
        interactor.loadSearchedContacts(name: string)
    }
    
    func resetSearch() {
        interactor.resetSearch()
    }
    
    func checkPagination(index: Int, arrayCount: Int) {
        if index == arrayCount - 5 {
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
        { [weak self] (item, cell, section, row) -> UserSearchTableViewCell in
            cell.contact = item
            self?.checkPagination(index: row, arrayCount: contactList.count)
            
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
