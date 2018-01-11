//
//  AIUserFriendsListAIUserFriendsListInteractor.swift
//  BrowserVK
//
//  Created by Ilyas on 10/01/2018.
//  Copyright © 2018 Ilyas. All rights reserved.
//

class UserFriendsListInteractor: UserFriendsListInteractorInput {

    weak var output: UserFriendsListInteractorOutput!
    var apiFacade: IApiFacade!
    
    init(apiFacade: IApiFacade) {
        self.apiFacade = apiFacade
    }

    func loadUserFriendsList(userID: Int) {
        apiFacade.loadUserFriendsList(userID: userID, successHundler: { [weak self] (successObject) in
            guard let strongSelf = self, let friends = successObject else { return }
            strongSelf.output.loadedUserFriendsList(friendList: friends)
            }, errorHundler: { [weak self] (error) in
                self?.output.showError(error)
                CocoaLumberjackService.error(error.localizedDescription)
        })
    }
}
