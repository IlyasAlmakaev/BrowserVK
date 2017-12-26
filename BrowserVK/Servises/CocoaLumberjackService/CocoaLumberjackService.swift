//
//  CocoaLumberjackService.swift
//  BrowserVK
//
//  Created by Ильяс on 24.12.2017.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import Foundation
import CocoaLumberjack

let defaultLogLevel: DDLogLevel = DDLogLevel.all

/**
 @author Ilyas Almakaev
 Сервис для логирования данных
 */

class CocoaLumberjackService {   
    
    static func error(_ text: String?,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line,
                      column: Int = #column) {
        let message = " > [ERROR] [\(file) | \(function) - \(line) - \(column): \(text ?? "")\n"
        DDLogError(message, file: file, function: function, line: line)
    }
    
    static func stringLogs() -> String {
        let fileManager: DDLogFileManagerDefault = DDLogFileManagerDefault()
        guard let filePath = fileManager.sortedLogFileInfos.last?.filePath else { return "" }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return "" }
        
        return String(data: data, encoding: String.Encoding.utf8) ?? ""
    }
    
    static func logs() -> Data? {
        let fileManager = DDLogFileManagerDefault()
        guard let fileInfo = fileManager?.sortedLogFileInfos.last else { return nil }
        let filePath = fileInfo.filePath
        let data = try? Data(contentsOf: URL(fileURLWithPath: filePath!))
        
        return data
    }
}
