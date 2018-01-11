//
//  ApiFacade.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import SwiftyVK

/**
 @author Ilyas Almakaev
 Фасад по vk api
 */

class ApiFacade: VKDelegate {
    
    var userSearchInteractor: UserSearchInteractorInput!
    var userInfoInterator: UserInfoInteractorInput!
    private let scopes: Set<VK.Scope> = [.messages,.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email] // REVIEW: Вынести в константы

    init() {
        VK.config.logToConsole = true
        VK.configure(withAppId: Const.VK.appID, delegate: self)
        VK.logIn()
    }
    
    func vkWillAuthorize() -> Set<VK.Scope> {
        return scopes
    }

    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TestVkDidAuthorize"), object: nil)
    }

    func vkAutorizationFailedWith(error: AuthError) {
        CocoaLumberjackService.error(error.localizedDescription)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TestVkDidNotAuthorize"), object: nil)
    }

    func vkDidUnauthorize() {}

    func vkShouldUseTokenPath() -> String? { return nil }
    
    func vkWillPresentView() -> UIViewController {
        guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else { return UIViewController() }
        return rootViewController
    }
}

extension ApiFacade: IApiFacade {
    
    // Mark: load data
    
    func loadSearchedContacts(name: String,
                              countContacts: Int,
                              successHundler: @escaping ([Contact]?) -> Void,
                              errorHundler: @escaping (Error) -> Void) {
        VK.API.Users.search([.q: name,
                             .offset: String(countContacts),
                             .limit: "20",
                             .fields: "photo_50, nickname"]).send(
            onSuccess: { [weak self] (response) in
                guard let objects = response["items"].arrayObject, let strongSelf = self else {
                    return successHundler(nil)
                }
                DispatchQueue.main.async {
                    successHundler(strongSelf.getSearchedContacts(objects: objects))
                }
            },
            onError: { (error) in
                DispatchQueue.main.async {
                    CocoaLumberjackService.error(error.localizedDescription)
                    
                    errorHundler(error)
                }   
        }
        )
    }
    
    func loadUserInfo(userID: Int,
                      successHundler: @escaping (Any?) -> Void,
                      errorHundler: @escaping (Error) -> Void) {
        VK.API.Users.get([.userId: String(userID),
                          .fields: Const.VK.userFields]).send(
            onSuccess: { (response) in
                guard let object = response.arrayObject?[0] else { return }
                
                DispatchQueue.main.async {
                    successHundler(object)
                }
        },
            onError: { (error) in
                DispatchQueue.main.async {
                    CocoaLumberjackService.error(error.localizedDescription)
                    
                    errorHundler(error)
                }
        }
        )
    }
    
    func loadUserFriendsList(userID: Int,
                      successHundler: @escaping ([Friend]?) -> Void,
                      errorHundler: @escaping (Error) -> Void) {
        VK.API.Friends.get([.userId: String(userID),
                          .fields: Const.VK.userFriendsFields]).send(
                            onSuccess: { [weak self] (response) in
                                
                                guard let objects = response["items"].arrayObject, let strongSelf = self else {
                                    return successHundler(nil)
                                }
                                DispatchQueue.main.async {
                                    successHundler(strongSelf.getUserFriends(objects: objects))
                                }
                          },
                            onError: { (error) in
                                DispatchQueue.main.async {
                                    CocoaLumberjackService.error(error.localizedDescription)
                                    
                                    errorHundler(error)
                                }
                          }
        )
    }
    
    // Mark: convert data
    
    func getSearchedContacts(objects: Array<Any>?) -> [Contact] {
        guard let objects = objects else { return [] }
        var contacts: [Contact] = []
        for object in objects {
            guard let contact = Contact(map: object as AnyObject) else { continue }
            contacts.append(contact)
        }
        
        return contacts
    }
    
    func getUserFriends(objects: Array<Any>?) -> [Friend] {
        guard let objects = objects else { return [] }
        var friends: [Friend] = []
        for object in objects {
            guard let friend = Friend(map: object as AnyObject) else { continue }
            friends.append(friend)
        }
        
        return friends
    }
}
