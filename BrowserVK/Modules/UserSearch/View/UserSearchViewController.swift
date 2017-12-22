//
//  UserSearchViewController.swift
//  BrowserVK
//
//  Created by Ильяс on 13.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

//
//  UserSearchAIUserSearchViewController.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

let UserSearchCellID = "UserSearchCell"

class UserSearchViewController: UIViewController, UserSearchViewInput {
    
    var output: UserSearchViewOutput!
    var searchResults = [Contact]()
    let searchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()
    var nameContact = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialState()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    // MARK: UserSearchViewInput
    func setupInitialState() {
        
        // configurate table view cell
        tableView.register(cell: UserSearchTableViewCell.self)
        tableView.registerHeight(cell: UserSearchTableViewCell.self)
        tableView.tableFooterView = UIView(frame: .zero)
        
        // configurate search controller
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        
        // cofigurate refresh control
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(searchWithRefreshControl), for: .valueChanged)
        
        definesPresentationContext = true
    }
    
    func provideTableDataSource(datasource: AnyTableDataSource) {
        tableView.delegate = datasource
        tableView.dataSource = datasource
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func loadedSearchedContacts(contacts: [Contact]) {
        searchResults = contacts
    }
    
    func startAnimatingActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimatingActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    @objc func searchWithRefreshControl() {
        output.search(string: nameContact)
    }
    
    func stopRefreshControl() {
        refreshControl.endRefreshing()
    }
}

extension UserSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startAnimatingActivityIndicator()
        nameContact = searchBar.text!
        output.search(string: nameContact)
    }
}
