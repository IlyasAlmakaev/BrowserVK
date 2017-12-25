//
//  ApiFacade.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import SwiftyVK

class ApiFacade: VKDelegate {
    
    let vkAppID = "6265118"
    let scopes: Set<VK.Scope> = [.messages,.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email]
    var searchResults: [Any] = []
    var userInfoResults = Contact()
    
    var userSearchInteractor: UserSearchInteractorInput!
    var userInfoInterator: UserInfoInteractorInput!

    init() {
        VK.config.logToConsole = true
        VK.configure(withAppId: vkAppID, delegate: self)
    }
    
    func vkWillAuthorize() -> Set<VK.Scope> {
        return scopes
    }

    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TestVkDidAuthorize"), object: nil)
    }

    func vkAutorizationFailedWith(error: AuthError) {
        print("Autorization failed with error: \n\(error)")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TestVkDidNotAuthorize"), object: nil)
    }

    func vkDidUnauthorize() {}

    func vkShouldUseTokenPath() -> String? {
        return nil
    }
    
    func vkWillPresentView() -> UIViewController {
        return UIApplication.shared.delegate!.window!!.rootViewController!
    }
}

extension ApiFacade: IApiFacade {
    func loadSearchedContacts(name: String, countContacts: Int, successHundler: @escaping (Array<Any>?, Bool) -> Void, errorHundler: @escaping (Error) -> Void) {
        
        VK.API.Users.search([.q: name, .offset: String(countContacts), .limit: "20", .fields: "photo_50, nickname"]).send(
            onSuccess: { [weak self]
                response in
                guard let strongSelf = self else { return }
                guard let objects = response["items"].arrayObject else { return }
                var hasMore = false
                
                if objects.count == 20 {
                    hasMore = true
                }
                
                strongSelf.searchResults += objects
//                
//                let errorTemp = NSError(domain:"", code:404, userInfo:nil)
//                
//                errorHundler(errorTemp)
                
                DispatchQueue.main.async {
                    successHundler(self?.searchResults, hasMore)
                }
            },
            onError: { error in
                DispatchQueue.main.async {
                    errorHundler(error)
                }   
        }
        )
    }
    
    func loadUserInfo(userID: Int, successHundler: @escaping (Any?) -> Void, errorHundler: @escaping (Error) -> Void) {
        
        VK.API.Users.get([.userId: String(userID), .fields: "photo_200,nickname,screen_name,relation,sex"]).send(
            onSuccess: { response in
                
                guard let object = response.arrayObject?[0] else { return }
                
                DispatchQueue.main.async {
                    successHundler(object)
                }
        },
            onError: { error in
                DispatchQueue.main.async {
                    errorHundler(error)
                }
        }
        )
    }
    
    func resetSearch() {
        searchResults = []
    }
}
