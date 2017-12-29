//
//  AppDelegate.swift
//  BrowserVK
//
//  Created by Ильяс on 12.12.17.
//  Copyright © 2017 Ильяс. All rights reserved.
//

import UIKit
//import SwiftyVK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var container: MainContainer!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        
        window = UIWindow(frame: UIScreen.main.bounds) // REVIEW: Вынести работу с window в отдельный сервис
        container = MainContainer()
        
        return true
    }
    
    //TODO: возможно, удалить
//    @available(iOS 9.0, *)
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        let app = options[.sourceApplication] as? String
//        VK.process(url: url, sourceApplication: app)
//        print("authhh")
//        return true
//    }
//    
//    
//    
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        VK.process(url: url, sourceApplication: sourceApplication)
//        return true
//    }
}

