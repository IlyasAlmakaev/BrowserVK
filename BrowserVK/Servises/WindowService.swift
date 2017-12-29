//
//  WindowService.swift
//  BrowserVK
//
//  Created by Ильяс on 29.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit

/**
 @author Ilyas Almakaev
 Сервис для работы с Window
 */

class WindowService {
    func openRootController(window: UIWindow, viewController: UIViewController) {
        let navigation = UINavigationController(rootViewController: viewController)
        
        window.backgroundColor = UIColor.white
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
