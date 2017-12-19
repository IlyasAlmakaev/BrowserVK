//
//  UserInfoAIUserInfoViewController.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import SDWebImage

let UserInfoCellID = "UserInfoCell"

class UserInfoViewController: UIViewController, UserInfoViewInput {
    
    var output: UserInfoViewOutput!
    var userInfoResults = ContactDetail()
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        setupInitialState()
    }
    
    
    // MARK: UserInfoViewInput
    func setupInitialState() {
        
        // configurate table view cell
        let nibCell = UINib(nibName: String(describing: UserInfoTableViewCell.self), bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: UserInfoCellID)
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        self.edgesForExtendedLayout = []
    }
    
    func loadedUserInfo(info: ContactDetail) {
        userInfoResults = info
        
        navigationItem.title = "\(userInfoResults.lastName) \(userInfoResults.firstName)"
        
        let url = NSURL(string: userInfoResults.urlImageLarge)!
        avatar.sd_setImage(with: url as URL, completed: nil)
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
}

extension UserInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCellID, for: indexPath) as! UserInfoTableViewCell
        
        CellObjectFactory().configurateCell(cell: cell, row: indexPath.row, info: self.userInfoResults)
        
        return cell
    }
}
