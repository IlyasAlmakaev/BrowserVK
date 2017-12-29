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
        checkOnAuthorization() 
    }
    
    func vkWillAuthorize() -> Set<VK.Scope> {
        return scopes
    }

    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TestVkDidAuthorize"), object: nil)
    }

    func vkAutorizationFailedWith(error: AuthError) {
        CocoaLumberjackService.error(error.localizedDescription)
        print(CocoaLumberjackService.stringLogs())
        
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
    
    func loadSearchedContacts(name: String,
                              countContacts: Int,
                              successHundler: @escaping (Array<Any>?) -> Void,
                              errorHundler: @escaping (Error) -> Void) {
        VK.API.Users.search([.q: name,
                             .offset: String(countContacts),
                             .limit: "20",
                             .fields: "photo_50, nickname"]).send(
            onSuccess: { (response) in
                guard let objects = response["items"].arrayObject else { return successHundler(nil) }
                DispatchQueue.main.async {
                    successHundler(objects)
                }
            },
            onError: { (error) in
                DispatchQueue.main.async {
                    CocoaLumberjackService.error(error.localizedDescription)
                    print(CocoaLumberjackService.stringLogs())
                    
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
                    print(CocoaLumberjackService.stringLogs())
                    
                    errorHundler(error)
                }
        }
        )
    }
    
    func checkOnAuthorization() {
        if VK.state != .authorized {
            VK.logOut()
            VK.logIn()
        }
    }
}
