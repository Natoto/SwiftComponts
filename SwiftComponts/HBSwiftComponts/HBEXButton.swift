//
//  HBEXButton.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/12.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit

public extension UIButton {
    
    private struct cs_associatedKeys {
        
        static var accpetEventInterval  = "cs_acceptEventInterval"
        static var acceptEventTime      = "cs_acceptEventTime"
        
    }
    
    // 重复点击的间隔
    var cs_accpetEventInterval: TimeInterval {
        get {
            if let accpetEventInterval = objc_getAssociatedObject(self, &cs_associatedKeys.accpetEventInterval) as? TimeInterval {
                return accpetEventInterval
            }
            return 1.0
        }
        
        set {
            objc_setAssociatedObject(self, &cs_associatedKeys.accpetEventInterval, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var cs_acceptEventTime: TimeInterval {
        get {
            if let acceptEventTime = objc_getAssociatedObject(self, &cs_associatedKeys.acceptEventTime) as? TimeInterval {
                return acceptEventTime
            }
            
            return 1.0
        }
        
        set {
            objc_setAssociatedObject(self, &cs_associatedKeys.acceptEventTime, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    override open class func initialize() {
        let before: Method = class_getInstanceMethod(self, #selector(UIButton.sendAction))
        let after: Method  = class_getInstanceMethod(self, #selector(UIButton.cs_sendAction(action:to:forEvent:)))
        
        method_exchangeImplementations(before, after)
    }
    
    func cs_sendAction(action: Selector, to target: AnyObject?, forEvent event: UIEvent?) {
        
        self.logmethod()
        if NSDate().timeIntervalSince1970 - self.cs_acceptEventTime < self.cs_accpetEventInterval {
            return
        }
        
        if self.cs_accpetEventInterval > 0 {
            self.cs_acceptEventTime = NSDate().timeIntervalSince1970
        }
        
        self.cs_sendAction(action: action, to: target, forEvent: event)
    }
    
}


class HBEXButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
