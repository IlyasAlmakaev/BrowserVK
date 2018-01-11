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
    var friendList: [FriendPresenter] = [] // REVIEW: View не должно знать о данных
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
        collectionView.register(UINib(nibName: "UserFriendListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserFriendListCollectionViewCell")
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 60.0, height: 60.0)
        }
    }
    
    func loadedUserFriendsList(friendList: [FriendPresenter]) {
        self.friendList = friendList
        collectionView.reloadData()
    }
}

extension UserFriendsListViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserFriendListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserFriendListCollectionViewCell", for: indexPath) as! UserFriendListCollectionViewCell
        /* REVIEW:
         1: При indexPath.row >= friendList.count - словим краш
         2: Реализовать метод получения present-модели из презентера
         3: Пусть ячейка сама себя заполняет func setup(model: FriendPresenter)
         */
        let friend = friendList[indexPath.row]
        
        cell.fullName.text = friend.fullName
        let image = UIImage(named: "contact_default@50")
        cell.avatar.kf.setImage(with: friend.urlImage, placeholder: image)
        
        return cell;
    }
}
