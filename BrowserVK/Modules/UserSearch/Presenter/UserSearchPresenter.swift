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
    private var tableDatasource: AnyTableDataSource = AnyTableDataSource()
    private var disposedBag: DisposeBag = DisposeBag()
    
    func viewIsReady() {
        interactor.contactsVariable.asObservable().subscribe(onNext: { (contacts) in
            let contactsPresenter = self.prepareContactsPresenter(contacts: contacts)
            self.provideDataSource(contactsPresenter)
            self.stopAnimateUpdate()
        }).addDisposableTo(disposedBag)
    }
    
    func stopAnimateUpdate() {
        self.view.stopAnimatingActivityIndicator()
        self.view.stopRefreshControl()
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
    
    func prepareContactsPresenter(contacts: [Contact]) -> [ContactPresenter] {
        var contactsPresenter: [ContactPresenter] = []
        for contact in contacts {
            let contactPresenter = ContactPresenter(contact: contact)
            contactsPresenter.append(contactPresenter)
        }
        return contactsPresenter
    }
    
    // Mark: TableView
    
    func provideDataSource(_ contactList: [ContactPresenter]) {
        tableDatasource.clear()
        let contactFactory: (ContactPresenter, UserSearchTableViewCell, Int, Int) -> UserSearchTableViewCell =
        { [weak self] (item, cell, section, row) -> UserSearchTableViewCell in
            cell.contact = item
            self?.checkPagination(index: row, arrayCount: contactList.count)
            
            return cell
        }
        let selectRowAction: ((ContactPresenter) -> Void) = { [weak self] (item) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.router.openUserInfoViewController(userID: item.id)
        }
        tableDatasource.registerSection(for: UserSearchTableViewCell.self, for: ContactPresenter.self, with: contactList, factory: contactFactory, selectAction: selectRowAction)
        view.provideTableDataSource(datasource: tableDatasource)
        view.updateTableView()
    }
    
    // Mark: Error
    
    func showError(_ error: Error) {
        router.showErrorAlert(errorDescription: error.localizedDescription)
        stopAnimateUpdate()
    }
}
