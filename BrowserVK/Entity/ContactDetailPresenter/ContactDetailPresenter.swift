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
        
        let sexEnum = Sex(rawValue: contactDetail.sex)
        guard let sex = sexEnum?.description else { return }
        self.sex = sex
        
        let relationEnum = Relation(rawValue: contactDetail.relation ?? 0)
        guard let relation = relationEnum?.description else { return }
        self.relation = relation
        
        self.urlImageLarge = URL(string: contactDetail.urlImageLarge) ?? nil
    }
    
    enum Sex: Int {
        case Unknown, Female, Male
        var description: String {
            switch self {
            case .Unknown:
                return "Пол не указан"
            case .Female:
                return "Женщина"
            case .Male:
                return "Мужик"
            }
        }
    }
    
    enum Relation: Int {
        case NoneSelected, Single, InARelationship, Engaged, Married, ItsComplicated, InLove, InACivilUnion
        var description: String {
            switch self {
            case .NoneSelected:
                return "Не указано"
            case .Single:
                return "Не женат/не замужем"
            case .InARelationship:
                return "Есть друг/есть подруга"
            case .Engaged:
                return "Помолвлен/помолвлена"
            case .Married:
                return "Женат/замужем"
            case .ItsComplicated:
                return "Всё сложно"
            case .InLove:
                return "Влюблён/влюблена"
            case .InACivilUnion:
                return "В гражданском браке"
            }
        }
    }
}
