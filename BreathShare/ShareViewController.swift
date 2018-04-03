//
//  ShareViewController.swift
//  BreathShare
//
//  Created by LinMo on 2018/1/19.
//  Copyright © 2018年 LinMo. All rights reserved.
//


import UIKit
import MobileCoreServices

class ShareViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func openUrl(url: URL?) {
        let selector = sel_registerName("openURL:")
        var responder = self as UIResponder?
        while let r = responder, !r.responds(to: selector) {
            responder = r.next
        }
        _ = responder?.perform(selector, with: url)
    }
    
    @objc func openURL(_ url: URL) {
        return
    }
    
    func openContainerApp() {
        var responder: UIResponder? = self as UIResponder
        let selector = #selector(ShareViewController.openURL(_:))
        
        while responder != nil {
            if responder!.responds(to: selector) && responder != self {
                responder!.perform(selector, with: URL(string: "breath://")!)
                return
            }
            responder = responder?.next
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = NSURL(string: "breath://")!
//        self.openUrl(url: url)
//         self.openURL(url: url)
//       self.openContainerApp()
    }
    override func viewDidAppear(_ animated: Bool) {
        //之前的尝试一直失败的核心语句
        self.openContainerApp()
        self.done();
    }
    
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
