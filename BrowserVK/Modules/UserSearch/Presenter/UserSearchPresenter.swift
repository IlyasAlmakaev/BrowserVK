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
        
    }
    
    func search(string: String) {
        resetSearch()
        interactor.loadSearchedContacts(name: string)
    }
    
    func resetSearch() {
        interactor.resetSearch()
    }
    
    func loadedSearchedContacts(contacts: [Contact]) {
//        view.loadedSearchedContacts(contacts: contacts)
//        view.updateTableView()
        provideDataSource(contacts)
        view.stopAnimatingActivityIndicator()
        view.stopRefreshControl()
    }
    
//    func openUserInfoViewController(navigationController: UINavigationController, id: Int) {
//        router.openUserInfoViewController(userID: id)
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
    
//    func provideDataSource(_ addressList: [ProfileAddress]) {
//        tableDatasource.clear()
//        let addressFactory: ((ProfileAddress, AddressListCell, Int, Int) -> AddressListCell) =
//        { [weak self] (item, cell, section, index) -> AddressListCell in
//            let selected = (item == self?.selectedAddress)
//            cell.setup(addressTitle: item.addressTitleWithoutTown(),
//                       town: item.town ?? "",
//                       selected: selected,
//                       delegate: self,
//                       statusModel: item.statusViewModel(),
//                       index: (section: section, row: index))
//            return cell
//        }
//        let selectRowAction: ((ProfileAddress) -> Void) = { [weak self] (item) -> Void in
//            self?.interactor.select(address: item)
//        }
//        let addAddressFactory: (Empty, AddAddressCell, Int, Int) -> AddAddressCell =
//        { (_, cell, _, _) -> AddAddressCell in
//            cell.setup()
//            return cell
//        }
//        let addAddressSelectRowAction: ((Empty) -> Void) = { [weak self] (item) -> Void in
//            EventSender.event(ProfileEvent.addNextAddress()).send()
//            self?.router.moveToAddAddress()
//        }
//        tableDatasource.registerSection(for: AddressListCell.self,
//                                        with: addressList,
//                                        factory: addressFactory,
//                                        selectAction: selectRowAction,
//                                        header: nil)
//        tableDatasource.registerSection(for: AddAddressCell.self, with: Empty(), factory: addAddressFactory, selectAction: addAddressSelectRowAction)
//        tableDatasource.register(section: 0, height: AddressListCell.height)
//        tableDatasource.register(section: 1, height: AddAddressCell.height)
//        view.provideTableDataSource(datasource: tableDatasource)
//        view.reload()
//    }
//    
//    func provideDatasourceToView(_ addressItems: [AddressItemViewModel]) {
//        view.provideTableDataSource(dataSource: tableDatasource)
//        tableDatasource.clear()
//        let townsFactory: ((AddressItemViewModel, SelectAddressCell, Int, Int) -> SelectAddressCell) =
//        { (item, cell, section, row) -> SelectAddressCell in
//            cell.needRoundTopCorners = (section == 0 && row == 0)
//            cell.setup(title: item.title)
//            return cell
//        }
//        let selectRowAction: ((AddressItemViewModel) -> Void) = { [weak self] (item) -> Void in
//            guard let type = self?.type else { return }
//            self?.interactor.selectAddressItem(by: item, addressType: type)
//            self?.router.closeSelectAddressController()
//        }
//        tableDatasource.registerSection(for: SelectAddressCell.self,
//                                        with: addressItems,
//                                        factory: townsFactory,
//                                        selectAction: selectRowAction,
//                                        header: nil)
//        tableDatasource.register { [weak self] (x, y) in
//            self?.view.tableScrolledToOffset(x: x, y: y)
//        }
//        view.reload()
//    }
}
