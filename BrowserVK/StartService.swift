//
//  StartService.swift
//  BrowserVK
//
//  Created by Ильяс on 19.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import UIKit

class StartService {
    
    func start(window: UIWindow, viewController: UIViewController) {
        let navigation = UINavigationController(rootViewController: viewController)
        
        window.backgroundColor = UIColor.white
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
