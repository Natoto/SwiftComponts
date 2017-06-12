//
//  EXHBTableViewController.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/9.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit
import HBKit

extension HBBaseTableViewController{
    
    func run_after(sec:Int,complete:@escaping ()->()) -> () {
        let time:DispatchTime  = DispatchTime.now() + .seconds(sec)
        DispatchQueue.main.asyncAfter(deadline: time) { 
           complete()
        };
    }
    
    func createcell(title:String) -> HBCellStruct {
        let cs:HBCellStruct! = HBCellStruct.init(title: title, cellclass: "HBBaseTableViewCell", placeholder: "", accessory: true, sel_selctor:#selector(cs_selectAction(cs:)) , delegate: self)
        return cs
    }
    
    func cs_selectAction(cs:HBCellStruct) ->()  {
        print(cs.title)
    }
    
    func cs_titles() -> [String] {
        return  ["test"];
    }
    
    
    func cs_loadcsdata() -> () {
        let titles = self.cs_titles
        var idx = 0
        for x in titles() {
            let cs:HBCellStruct! = self.createcell(title: x)
            cs.key_indexpath = self.key_indexpath(0,row:idx)
            self.dataDictionary.setObject(cs, forKey: self.key_indexpath(0, row: idx)! as NSCopying)
            idx = idx+1
        }
    }
}

