//
//  UserSearchAIUserSearchPresenter.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import RxSwift

class UserSearchPresenter: BasePresenter, UserSearchModuleInput, UserSearchViewOutput, UserSearchInteractorOutput {
    
    weak var view: UserSearchViewInput!
    var interactor: UserSearchInteractorInput!
    var userSearchRouter: UserSearchRouterInput!
    fileprivate var nameContact = ""
    private var tableDatasource: AnyTableDataSource = AnyTableDataSource()
    private var disposedBag: DisposeBag = DisposeBag()
    private var isLoad: Bool!
    
    init(router: UserSearchRouterInput) {
        userSearchRouter = router
    }
    
    func viewIsReady() {
        interactor.contactsVariable.asObservable().subscribe(onNext: { [weak self] (contacts) in 
            guard let strongSelf = self else { return }
            let contactsPresenter = strongSelf.prepareContactsPresenter(contacts: contacts)
            strongSelf.loadContacts(contactsPresenter)
        }).addDisposableTo(disposedBag)
        
        view.refreshControl.addTarget(self, action: #selector(searchWithRefreshControl), for: .valueChanged)
    }
    
    func loadContacts(_ contacts: [ContactPresenter]) {
        isLoad = false
        provideDataSource(contacts)
        view.animateLoadingIndicators(isLoad: isLoad)
    }
    
    func search(string: String) {
        resetSearch()
        if string.isEmpty {
            loadContacts([])
        } else {
            nameContact = string
            isLoad = true
            interactor.loadSearchedContacts(name: nameContact)
        }
    }
    
    func searchWithRefreshControl() {
        search(string: nameContact)
    }
    
    func resetSearch() {
        interactor.resetSearch()
    }
    
    func checkPagination(index: Int, arrayCount: Int) {
        if index == arrayCount - 5 {
            isLoad = true
            if interactor.hasMore {
                view.animateLoadingIndicators(isLoad: isLoad)
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
            strongSelf.userSearchRouter.openUserInfoViewController(userID: item.id)
        }
        tableDatasource.registerSection(for: UserSearchTableViewCell.self, for: ContactPresenter.self, with: contactList, factory: contactFactory, selectAction: selectRowAction)
        view.provideTableDataSource(datasource: tableDatasource)
        view.updateTableView()
    }
    
    // Mark: Error
    
    override func showError(_ error: Error) {
        userSearchRouter.showErrorAlert(errorDescription: error.localizedDescription)
        isLoad = false
        view.animateLoadingIndicators(isLoad: isLoad)
    }
}
