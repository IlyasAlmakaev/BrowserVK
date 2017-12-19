//
//  CellObjectFactory.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation

class CellObjectFactory {
    
    func configurateCell(cell: UserInfoTableViewCell, row: Int, info: ContactDetail) {
        
        var text = ""
        var detailText = ""
        
        switch row {
        case 0:
            text = "Имя"
            detailText = info.firstName
        case 1:
            text = "Фамилия"
            detailText = info.lastName
        case 2:
            text = "Отчество"
            detailText = info.nickName
        case 3:
            text = "screenname"
            detailText = info.screenname
        case 4:
            text = "Пол"
            detailText = sex(sex: info.sex)
        case 5:
            text = "Семейное положение"
            detailText = relation(relation: info.relation, sex:info.sex)
        default:
            break
        }
        
        cell.textLabel?.text = text
        cell.detailTextLabel?.text = detailText
    }
    
    func sex(sex: Int) -> String {
        
        var sexText = ""
        
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
