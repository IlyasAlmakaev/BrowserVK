//
//  UserSearchTableViewCell.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit
import SDWebImage

class UserSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    var contact = Contact() {
        didSet {
            fullName.text = "\(contact.lastName) \(contact.firstName)"
            let url = NSURL(string: contact.urlImage)!
            avatar.sd_setImage(with: url as URL, completed: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
