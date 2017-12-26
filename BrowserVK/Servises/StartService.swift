//
//  StartService.swift
//  BrowserVK
//
//  Created by Ильяс on 19.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit
import CocoaLumberjack

/**
 @author Ilyas Almakaev
 Сервис при старте приложения
 */

class StartService {
    
    func start(window: UIWindow, viewController: UIViewController) {
        let navigation = UINavigationController(rootViewController: viewController)
        
        window.backgroundColor = UIColor.white
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    func startLogger() {
        DDLog.add(DDTTYLogger.sharedInstance)
        DDLog.add(DDASLLogger.sharedInstance)
        
        let fileLogger: DDFileLogger = DDFileLogger()
        fileLogger.rollingFrequency = TimeInterval(60*60*24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
}
