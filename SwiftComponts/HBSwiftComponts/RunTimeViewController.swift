//
//  RunTimeViewController.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/21.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit
import HBKit
//swift类本身不具备动态性，不能使用runtime获得方法名称属性
//object-c是动态性，
//可以通过给变量或方法添加@objc标识其动态属性，即可给它赋予objc动态性

class HBPerson {

     var name = "no name"
     var age = 20
     func printName() -> () {
         print("name is \(name)")
    }
}

class HBPerson1 {
    @objc  var name = "no name"
    @objc var age = 20
    
    @objc func printName() -> () {
        print("name is \(name)")
    }
}


class RunTimeViewController: HBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getMethodAndPropertiesfromclass(cls: HBPerson.self)
        self.getMethodAndPropertiesfromclass(cls: HBPerson1.self)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMethodAndPropertiesfromclass(cls:AnyClass) -> () {
        
        print("\n\n\(NSStringFromClass(cls)) start method :\n")
        var methodNum : UInt32 = 0;
        let methods = class_copyIvarList(cls, &methodNum)
        
        for index in 0..<numericCast(methodNum) {
           
            let met:Method = methods![index]!
            print("m_name: \(method_getName(met))")
            
            let p = method_copyReturnType(met)
            let returntype = String.init(cString: p!)
            
            let p_attr = String.init(cString: method_getTypeEncoding(met))
            print("m_returentype:\(String(describing: returntype))")
            print("m_attr: \(p_attr)")
            
        }
        
        
        print("\n\nstart properties :\n")
        var proNum :UInt32 = 0
        let properties = class_copyPropertyList(cls, &proNum)
        for index in 0..<numericCast(proNum) {
            
            let prop:objc_property_t = properties![index]!
            print("p_name: \(String.init(cString: property_getName(prop)))")
            print("p_attr: \(String.init(cString: property_getAttributes(prop)))")
        }
    }
    
    func swizzMetho(cls:AnyClass,orginMethod:Selector,destMethod:Selector) {
        let origin = class_getInstanceMethod(cls, orginMethod);
        let swiz = class_getInstanceMethod(cls, destMethod)
        method_exchangeImplementations(origin, swiz)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
