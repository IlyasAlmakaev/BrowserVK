//
//  StartService.swift
//  BrowserVK
//
//  Created by Ильяс on 19.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit
import CocoaLumberjack
import Swinject

/**
 @author Ilyas Almakaev
 Сервис при старте приложения
 */
// REVIEW: StartService ни как не относится к ApiFacade, как он оказался в его группе?
class StartService {
    
    func initRootController(container: Container) {
        guard let viewController = container.resolve(UserSearchConfigurator.self,
                                                     argument: UserSearchInputDataModel())?.viewController else { return }
        let windowService = WindowService()
        windowService.openRootController(viewController: viewController)
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
