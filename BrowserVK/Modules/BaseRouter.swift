//
//  BaseRouter.swift
//  BrowserVK
//
//  Created by Ильяс on 22.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit
import Toast_Swift

class BaseRouter: BaseRouterInput {
    
    var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showErrorAlert(errorDescription: String) {
        viewController.navigationController?.view.makeToast(errorDescription, duration: 3.0, position: .center)
    }
}
