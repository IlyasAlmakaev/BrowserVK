//
//  UserSearchTableViewCell.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit
import Kingfisher

class UserSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    var contact = ContactPresenter() {
        didSet {
            fullName.text = "\(contact.lastName) \(contact.firstName)"
            let image = UIImage(named: "contact_default@50")
            avatar.kf.setImage(with: contact.urlImage, placeholder: image)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
