//
//  HBLog.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/12.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit
 
extension NSObject{
     
//    func logmethod() -> (functionName: String) {
//        print("🔴：文件\(#file)（在第\(#line)行），方法：\(functionName)")
//    }
    
    public func logmethod(message: String="",
                   functionName:  String = #function, fileNameWithPath: String = #file, lineNumber: Int = #line ) {
     
        let fileNameWithoutPath = NSURL(fileURLWithPath: fileNameWithPath).lastPathComponent
        
        #if DEBUG
            let output = "🔴\(NSDate()): \(message) [\(functionName) in \(String(describing: fileNameWithoutPath)), line \(lineNumber)]"
            print(output)
        #endif
    }
}

class HBLog: NSObject {
 
}
