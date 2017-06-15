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
import Alamofire
class ModelExViewController: HBBaseTableViewController {

    override func cs_titles() -> [String] {
        return ["【0】从文件中加载json",
                "【1】网络加载",
                "【2】解析json到model",
                "【3】保存json",
                "【4】读取json",]
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
            self.jsontomodel()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 3){
            self.savejson()
        }
    }
    
    var json:JSON? = JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.cs_loadcsdata()
    }
    
    func savejson() -> () {
    
        if let file = Bundle.main.path(forResource: "PPGetHomeOpusListResp", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file))
                let json = try String.init(contentsOf: URL(fileURLWithPath: file))
                
                XHNetworkCache.save_asyncJsonResponseToCacheFile(json as AnyObject, URL: "http://baidu.com") { (result) in
                    
                    if(result)
                    {
                        print("(异步)保存/更新成功")
                    }
                    else
                    {
                        print("(异步)保存/更新成功")
                    }
                }

            } catch {
                self.json = JSON.null
            }
        } else {
            self.json = JSON.null
        }
    }
    
    func jsontomodel() -> () {
         self.loadfromlocal()
    }
    
    func loadfromnetwork() -> () {
        
        SVProgressHUD.show()
        Alamofire.request("http://7xicym.com1.z0.glb.clouddn.com/popaimg/PPGetHomeOpusListResp.json").responseJSON { (response:DataResponse) in
            
            do{
                let json = try JSON.init(data: response.data!)
                let resp = PPGetHomeOpusListResp.init(fromJson: json)
                self.json = json;
                  print(resp.description)
                SVProgressHUD.showSuccess(withStatus: "网络请求json成功转换成model")
            }catch{
                SVProgressHUD.dismiss()
            }
        }
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
