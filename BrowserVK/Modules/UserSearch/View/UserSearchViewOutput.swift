//
//  UserSearchAIUserSearchViewOutput.swift
//  BrowserVK
//
//  Created by Ilyas on 12/12/2017.
//  Copyright © 2017 Ilyas. All rights reserved.
//
import Foundation
import UIKit

@objc protocol UserSearchViewOutput {

    /**
        @author Ilyas
        Notify presenter that view is ready
    */

    func viewIsReady()
    
    func resetSearch()
    
    func search(string: String)
    
    func checkPagination(index: Int, arrayCount: Int)
    
//    func openUserInfoViewController(navigationController: UINavigationController, id: Int)
}
