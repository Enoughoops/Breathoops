//
//  ActionViewController.swift
//  BreathLess
//
//  Created by LinMo on 2018/1/8.
//  Copyright © 2018年 LinMo. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    func openUrl(url: URL?) {
        let selector = sel_registerName("openURL:")
        var responder = self as UIResponder?
        while !responder!.responds(to: selector) {
            responder = responder?.next
        }
        _ = responder?.perform(selector, with: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

//        let url = NSURL(string: "breath://")

//        let context = NSExtensionContext()
//        context.open(url! as URL, completionHandler: nil)

        self.openUrl(url:URL(string:"breath://")!)

//        self.openContainerApp();
    }
    
    //    func openURL(url: NSURL) -> Bool {
    //        do {
    //            let selectorOpenURL = sel_registerName("openURL:")
    //            let application = try self.sharedApplication()
    //            return application.perform(selectorOpenURL, with: url) != nil
    //        }
    //        catch {
    //            return false
    //        }
    //    }
    //
    //    func sharedApplication() throws -> UIApplication {
    //        var responder: UIResponder? = self
    //        while responder != nil {
    //            if let application = responder as? UIApplication {
    //                return application
    //            }
    //            responder = responder?.next
    //        }
    //
    //        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
    //    }
    
    
//    // For skip compile error.
//   @objc func openURL(_ url: URL) {
//        return
//    }
//
//    func openContainerApp() {
//        var responder: UIResponder! = self as UIResponder
//        let selector = #selector(openURL(_:))
//        while responder != nil {
//            let application = self as! UIApplication
//            if application.responds(to: selector) {
//                application.perform(selector, with: URL(string: "breath://")!)
//                return
//            }
//            responder = responder?.next
//        }
//    }
//
    


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }
    
}
