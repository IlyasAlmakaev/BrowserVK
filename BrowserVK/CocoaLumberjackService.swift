//
//  CocoaLumberjackService.swift
//  BrowserVK
//
//  Created by Ильяс on 24.12.2017.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import CocoaLumberjack

let defaultLogLevel: DDLogLevel = DDLogLevel.verbose

class CocoaLumberjackService {

    let fileLogger: DDFileLogger
   // public let ddLogLevel: DDLogLevel
    
    init() {
        DDLog.add(DDTTYLogger.sharedInstance)
        DDLog.add(DDASLLogger.sharedInstance)
        
        fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = TimeInterval(60*60*24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
        
        defaultDebugLevel = DDLogLevel.info
    }
}
