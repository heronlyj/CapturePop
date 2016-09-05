//
//  PopControlViewController.swift
//  CapturePopAction
//
//  Created by lyj on 9/5/16.
//  Copyright © 2016 heronlyj. All rights reserved.
//

import UIKit

class PopControlViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension PopControlViewController: PopControlAble {
    
    func shouldPop(controller controller: UINavigationController) -> Bool {
        
        let shouldPopAction = UIAlertAction(title: "泥奏凯, 别拦我", style: .Default) { (action: UIAlertAction) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        let cancel = UIAlertAction(title: "我再想想..", style: .Cancel, handler: nil)
        
        let alertController = UIAlertController(title: "真的要走吗.. /(ㄒoㄒ)/~~", message: nil, preferredStyle: .Alert)
        
        alertController.addAction(shouldPopAction)
        alertController.addAction(cancel)
        
        presentViewController(alertController, animated: true) {
            // 将 backButton 的颜色恢复原状
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.navigationItem.setHidesBackButton(false, animated: true)
        }
        
        return false
    }
    
}
