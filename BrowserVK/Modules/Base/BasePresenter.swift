//
//  BasePresenter.swift
//  BrowserVK
//
//  Created by Ильяс on 09.01.18.
//  Copyright © 2018 Ильяс. All rights reserved.
//

import Foundation

class BasePresenter {
    var router: UserInfoRouterInput!
    
    func showError(_ error: Error) { 
        router.showErrorAlert(errorDescription: error.localizedDescription)
    }
}
