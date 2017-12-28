//
//  UserSearchTableViewCell.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit
import Kingfisher

/**
 @author Ilyas Almakaev
Ячейка для отображения контакта в списке
 */

class UserSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    var contact = ContactPresenter() {
        didSet {
            fullName.text = contact.fullName
            let image = UIImage(named: "contact_default@50")
            avatar.kf.setImage(with: contact.urlImage, placeholder: image)
        }
    }
    //TODO: возможно, надо удалить
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
