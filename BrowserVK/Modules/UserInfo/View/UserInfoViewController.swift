//
//  UserInfoAIUserInfoViewController.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import Kingfisher

let UserInfoCellID = "UserInfoCell"

class UserInfoViewController: UIViewController, UserInfoViewInput {
    
    var output: UserInfoViewOutput!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var relationLabel: UILabel!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        setupInitialState()
    }
    
    
    // MARK: UserInfoViewInput
    func setupInitialState() {     
        self.edgesForExtendedLayout = []
    }
    
    func loadedUserInfo(contact: ContactDetailPresenter) {
        
        navigationItem.title = "\(contact.lastName) \(contact.firstName)"
        
        firstNameLabel.text = contact.firstName
        lastNameLabel.text = contact.lastName
        nicknameLabel.text = contact.nickName
        screennameLabel.text = contact.screenname
        sexLabel.text = contact.sex
        relationLabel.text = contact.relation
        
        let url = URL(string: contact.urlImageLarge)!
        avatar.kf.setImage(with: url)
    }
}

