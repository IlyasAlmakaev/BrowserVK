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
    
    var pageNumber = 0
    var currentName = ""
    
   
 
        
//        VK.API.Users.search([.q: name, .offset: String(pageNumber), .limit: "20", .fields: "photo_50, nickname"])
//            /*.configure(with: Config.init(httpMethod: .POST))*/
//            .onSuccess {
//                let result = JSON($0)["items"].arrayValue
//                
//                if result.count == 20 {
//                    self.interactor.hasMore = true
//                } else {
//                    self.interactor.hasMore = false
//                }
//                
//                self.searchResults += result
//                
//                DispatchQueue.main.async {
//                    self.interactor.loadedSearchedContacts(array: self.searchResults)
//                }
//            }
//            .onError { print("search user fail \n \($0)") }
//            .send()

    

        
//        VK.API.Users.get([.userId: String(id), .fields: "photo_200,nickname,screen_name,relation,sex"])
//            .onSuccess {
//                print("SwiftyVK: friends.get successed with \n \(JSON($0))")
//                let result = JSON($0).arrayValue
//                self.userInfoResults = result[0]
//                
//                DispatchQueue.main.async {
//                    self.interactorUserInfo.loadedUserInfo(info: self.userInfoResults)
//                }
//            }
//            .onError { print("SwiftyVK: friends.get failed with \n \($0)") }
//            .send()

    
    //TODO: initialise
    init() {
        VK.config.logToConsole = true
        VK.configure(withAppId: vkAppID, delegate: self)
    }
    
    // TODO: delete or commit
    func initVK() {
        VK.config.logToConsole = true
        VK.configure(withAppId: vkAppID, delegate: self)
    }
//
//    func vkNeedsScopes(for sessionId: String) -> Scopes {
//        return scopes
//    }
//    
//    func vkNeedToPresent(viewController: VKViewController) {
//        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
//            rootController.present(viewController, animated: true, completion: nil)
//        }
//    }
//    
//    func vkTokenCreated(for sessionId: String, info: [String : String]) {
//        
//    }
//    
//    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
//        
//    }
//    
//    func vkTokenRemoved(for sessionId: String) {
//        
//    }
    
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
    func loadSearchedContacts(name: String) {
        
        currentName = name
        
        VK.API.Users.search([.q: name, .offset: String(pageNumber), .limit: "20", .fields: "photo_50, nickname"]).send(
            onSuccess: { [weak self]
                response in
                
                let objects = response["items"].arrayObject
                
                if objects?.count == 20 {
                    self?.userSearchInteractor.hasMore = true
                } else {
                    self?.userSearchInteractor.hasMore = false
                }
                
                self?.searchResults += objects!
                
                DispatchQueue.main.async {
                    //  self!.interactor.loadedSearchedContacts(array: self.searchResults)
                    self!.userSearchInteractor.setSearchedContacts(objects: self?.searchResults)
                }
            },
            onError: { print("search user fail \n \($0)") }
        )
    }
    
    func loadUserInfo(userID: Int) {
        
        VK.API.Users.get([.userId: String(userID), .fields: "photo_200,nickname,screen_name,relation,sex"]).send(
            onSuccess: { [weak self]
                response in
                                print("SwiftyVK: friends.get successed with \n \(response))")
                //                let result = JSON($0).arrayValue
                //                self.userInfoResults = result[0]
                
                let object = response.arrayObject?[0]
                
                DispatchQueue.main.async {
                    self?.userInfoInterator.setUserInfo(object: object)
                    //  self.interactorUserInfo.loadedUserInfo(info: self.userInfoResults)
                }
            },
            onError: { print("SwiftyVK: friends.get failed with \n \($0)") }
        )
    }
    
    func getNextContacts() {
        pageNumber += 20
        loadSearchedContacts(name: currentName)
    }
    
    func resetSearch() {
        searchResults = []
        pageNumber = 0
    }
}
