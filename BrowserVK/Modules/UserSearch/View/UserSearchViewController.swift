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

class UserSearchViewController: UIViewController, UserSearchViewInput {
    
    var output: UserSearchViewOutput!
    fileprivate var nameContact = ""
    private let searchController = UISearchController(searchResultsController: nil)
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.searchController.searchBar.becomeFirstResponder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.checkOnAuthorization()
    }
    
    // MARK: UserSearchViewInput
    
    func provideTableDataSource(datasource: AnyTableDataSource) {
        tableView.delegate = datasource
        tableView.dataSource = datasource
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func animateLoadingIndicators(isLoad: Bool) {
        if isLoad {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            refreshControl.endRefreshing()
        }
    }
    
    @objc func searchWithRefreshControl() {
        output.search(string: nameContact)
    }
    

}

extension UserSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        animateLoadingIndicators(isLoad: true)
        nameContact = searchBar.text!
        output.search(string: nameContact)
    }
}
