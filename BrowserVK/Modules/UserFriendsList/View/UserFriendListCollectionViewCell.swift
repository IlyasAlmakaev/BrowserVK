//
//  UserFriendListCollectionViewCell.swift
//  BrowserVK
//
//  Created by Ильяс on 10.01.18.
//  Copyright © 2018 Ильяс. All rights reserved.
//

import UIKit
import Kingfisher

class UserFriendListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var avatar: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(model: FriendPresenter) {
        fullName.text = model.fullName
        let image = UIImage(named: "contact_default@50")
        avatar.kf.setImage(with: model.urlImage, placeholder: image)
    }
}
