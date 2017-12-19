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
        let nibCell = UINib(nibName: String(describing: UserSearchTableViewCell.self), bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: UserSearchCellID)
        
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

extension UserSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserSearchCellID, for: indexPath) as! UserSearchTableViewCell
        
        let contact = searchResults[indexPath.row]
        cell.contact = contact
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        output.checkPagination(index: indexPath.row, arrayCount: searchResults.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let id = searchResults[row].id
        output.openUserInfoViewController(navigationController: self.navigationController!, id: id)
    }
}

extension UserSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startAnimatingActivityIndicator()
        nameContact = searchBar.text!
        output.search(string: nameContact)
    }
}
