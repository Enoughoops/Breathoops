//
//  ShareViewController+sharedApplication.swift
//  BreathShare
//
//  Created by LinMo on 2018/1/19.
//  Copyright © 2018年 LinMo. All rights reserved.
//

import Foundation
import UIKit
extension ShareViewController {
    
    func openURL(url: NSURL) -> Bool {
        do {
             let selector = sel_registerName("openURL:")
            let application = try self.sharedApplication()
            return application.performSelector(inBackground: selector, with: url) != nil
        }
        catch {
            return false
        }
    }
    
    func sharedApplication() throws -> UIApplication {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application
            }
            
            responder = responder?.next
        }
        
        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
    }
    
}
