//
//  UserFriendsListAIUserFriendsListViewController.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class UserFriendsListViewController: UIViewController, UserFriendsListViewInput {

    var output: UserFriendsListViewOutput!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
        collectionView.register(UINib(nibName: "UserFriendListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserFriendListCollectionViewCell")
        collectionView.register(UINib(nibName: "EmptyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmptyCollectionViewCell")
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 60.0, height: 60.0)
        }
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension UserFriendsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.getUserFriendsListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserFriendListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserFriendListCollectionViewCell",
                                                                                        for: indexPath) as! UserFriendListCollectionViewCell

        guard let friend = output.getUserFriend(row: indexPath.row) else {
            let emptyCell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCollectionViewCell",
                                                                                            for: indexPath) as! EmptyCollectionViewCell

            return emptyCell
        }
        cell.setup(model: friend)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.openFriendInfo(row: indexPath.row)
    }
}
