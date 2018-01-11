//
//  UserFriendsListAIUserFriendsListViewController.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit
import Kingfisher

class UserFriendsListViewController: UIViewController, UserFriendsListViewInput {

    var output: UserFriendsListViewOutput!
    var friendList: [FriendPresenter] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
        self.collectionView.register(UINib(nibName: "UserFriendListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserFriendListCollectionViewCell")
    }


    // MARK: UserFriendsListViewInput
    func setupInitialState() {
        //TODO: возможно удалить
    }
    
    func loadedUserFriendsList(friendList: [FriendPresenter]) {
        self.friendList = friendList
        collectionView.reloadData()
    }
}

extension UserFriendsListViewController: UICollectionViewDataSource {
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendList.count
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserFriendListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserFriendListCollectionViewCell", for: indexPath) as! UserFriendListCollectionViewCell
        let friend = friendList[indexPath.row]
        
        cell.fullName.text = friend.fullName
        let image = UIImage(named: "contact_default@50")
        cell.avatar.kf.setImage(with: friend.urlImage, placeholder: image)
        
        return cell;
    }
}
