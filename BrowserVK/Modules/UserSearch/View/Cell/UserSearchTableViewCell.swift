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
            fullName.text = "\(contact.lastName) \(contact.firstName)" // REVIEW: Объединять поля надо в моделе презентации
            let image = UIImage(named: "contact_default@50")
            avatar.kf.setImage(with: contact.urlImage, placeholder: image)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none // REVIEW: Можно указать в .xib и не писать тут
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) { // REVIEW: не используемые методы стираем
        super.setSelected(selected, animated: animated)
    }
}
