//
//  ContactDetailView.swift
//  BrowserVK
//
//  Created by Ильяс on 21.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

/**
 @author Ilyas Almakaev
 Модель детальной информации о контакте для presenter-слоя
 */

class ContactDetailPresenter {
    
    /** id Контакта */
    var id: Int = 0
    /** Фамилия */
    var lastName: String = ""
    /** Имя */
    var firstName: String = ""
    /** Отчество */
    var nickName: String = ""
    /** screenname */
    var screenname: String = ""
    /** Пол */
    var sex: String = ""
    /** Семейное положение */
    var relation: String = ""
    /** Url-адрес картинки */
    var urlImageLarge: URL?
    
    init(contactDetail: ContactDetail?) {
        guard let contactDetail = contactDetail else { return }
        self.lastName = contactDetail.lastName
        self.firstName = contactDetail.firstName
        self.nickName = contactDetail.nickName
        self.screenname = contactDetail.screenname
        self.sex = sex(sex: contactDetail.sex)
        self.relation = relation(relation: contactDetail.relation, sex:contactDetail.sex)
        self.urlImageLarge = URL(string: contactDetail.urlImageLarge) ?? nil
    }
    
    func sex(sex: Int) -> String {
        
        var sexText = ""
        // REVIEW: Реализовать через Enum
        switch sex {
        case 0:
            sexText = "Пол не указан"
        case 1:
            sexText = "Женщина"
        case 2:
            sexText = "Мужик"
        default:
            break
        }
        
        return sexText
    }
    
    func relation(relation: Int?, sex: Int) -> String {
        
        var relationText = ""
        // REVIEW: Реализовать через Enum
        switch relation ?? 0 {
        case 0:
            relationText = "Не указано"
        case 1:
            if sex == 0 {
                relationText = "Не женат/не замужем"
            } else if sex == 1 {
                relationText = "Не замужем"
            } else {
                relationText = "Не женат"
            }
        case 2:
            if sex == 0 {
                relationText = "Есть друг/есть подруга"
            } else if sex == 1 {
                relationText = "Есть друг"
            } else {
                relationText = "Есть подруга"
            }
        case 3:
            if sex == 0 {
                relationText = "Помолвлен/помолвлена"
            } else if sex == 1 {
                relationText = "Помолвлена"
            } else {
                relationText = "Помолвлен"
            }
        case 4:
            if sex == 0 {
                relationText = "Женат/замужем"
            } else if sex == 1 {
                relationText = "Замужем"
            } else {
                relationText = "Женат"
            }
        case 5:
            relationText = "Всё сложно"
        case 6:
            relationText = "В активном поиске"
        case 7:
            if sex == 0 {
                relationText = "Влюблён/влюблена"
            } else if sex == 1 {
                relationText = "Влюблена"
            } else {
                relationText = "Влюблён"
            }
        case 8:
            relationText = "В гражданском браке"
        default:
            break
        }
        
        return relationText
    }
}
