//
//  HBEXNSObject.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/12.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit
import JCAlertController

extension NSObject{
    
    func presentAlert(msg:String) -> () {
         UIAlertView.init(title: "提示", message: msg, delegate: nil, cancelButtonTitle: "OK").show();
        
    }
    
    
}

extension UIViewController{
    
    override func presentAlert(msg: String) {
        let alert = JCAlertController.alert(withTitle: nil, message: msg);
        alert?.addButton(withTitle: "ok", type: JCButtonType(rawValue: 0), clicked: {
            print("press ok")
        })
        self.jc_present(alert, presentCompletion: {
            print("present Completion")
        }) { 
            print("dissmiss Completion")
        };
    }
}



class HBEXNSObject: NSObject {

}



