//
//  ModelExViewController.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/12.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation
import HBKit
import SVProgressHUD

class ModelExViewController: HBBaseTableViewController {

    override func cs_titles() -> [String] {
        return ["【0】从文件中加载json","【1】网络加载","【2】解析json到model"]
    }
    
    override func cs_selectAction(cs: HBCellStruct) {
        
        self.logmethod()
        if cs.key_indexpath == self.key_indexpath(0, row: 0) {
            self.loadfromlocal()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 1){
            self.loadfromnetwork()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 2){
            
        }
    }
    
    var json:JSON? = JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.cs_loadcsdata()
    }
    
    func loadfromnetwork() -> () {
        
    }
    
    func loadfromlocal() -> () {
    
        if let file = Bundle.main.path(forResource: "PPGetHomeOpusListResp", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file))
                let json = try JSON(data: data)
                self.json = json
                let resp = PPGetHomeOpusListResp.init(fromJson: json);
                print(resp.description);
                self.presentAlert(msg: json.description)
            } catch {
                self.json = JSON.null
            }
        } else {
            self.json = JSON.null
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
