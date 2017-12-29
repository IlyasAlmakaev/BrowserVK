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
    
    var window: UIWindow!
    
    init() {
        guard let application = UIApplication.shared.delegate as? AppDelegate, let window = application.window else { return }
        self.window = window
    }
    
    func openRootController(viewController: UIViewController) {
        let navigation = UINavigationController(rootViewController: viewController)
        
        window.backgroundColor = UIColor.white
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
