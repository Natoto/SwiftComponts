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
import Cache

class ModelExViewController: HBBaseTableViewController {

    override func cs_titles() -> [String] {
        return ["【0】从文件中加载json",
                "【1】网络加载",
                "【2】解析json到model",
                "【3】保存json",
                "【4】读取json",
                "【5】序列化保存实体",
                "【6】反序列化读取实体",]
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
        else if cs.key_indexpath == self.key_indexpath(0, row: 4){
            self.readjson()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 5){
            self.saveentity()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 6){
            self.readentity()
        }
    }
    
    var jsonobj:SwiftyJSON.JSON? = SwiftyJSON.JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.cs_loadcsdata()
    }
    
    func savejson() -> () {
    
        if let file = Bundle.main.path(forResource: "PPGetHomeOpusListResp", ofType: "json") {
            do {
                let jsonstr = try String.init(contentsOf: URL(fileURLWithPath: file))
                
                let cache = SyncHybridCache.init(BasicHybridCache.init(name: "json"))
                cache.add("str", object: "this is a string")
                cache.add("addkey", object: jsonstr)
                
                
            } catch {
                self.jsonobj = JSON.null
            }
        } else {
            self.jsonobj = JSON.null
        }
    }
    
    func readjson() -> () {
        
        let cache = SyncHybridCache.init(BasicHybridCache.init(name: "json"))
        let str:String! = cache.object("aakey");
        print(str)
        
    }
    //MARK: 保存实体 把数据序列化成data保存下来
    func saveentity() -> () {
        
        if let file = Bundle.main.path(forResource: "PPGetHomeOpusListResp", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file))
                let json = try SwiftyJSON.JSON(data: data)
                self.jsonobj = json
                let resp:PPGetHomeOpusListResp? = PPGetHomeOpusListResp.init(fromJson: json);
                let cache = SyncHybridCache.init(BasicHybridCache.init(name: "json"))
                let respdata = NSKeyedArchiver.archivedData(withRootObject: resp!);
                cache.add("jsonobj", object: respdata)
               SVProgressHUD.showSuccess(withStatus: "保存成功~~")
            } catch {
                self.jsonobj = SwiftyJSON.JSON.null
            }
        } else {
            self.jsonobj = SwiftyJSON.JSON.null
        }
    }
    
    //MARK:读取实体 从缓存中读取数据，并把数据反序列化成data
    func readentity() -> () {
        let cache = SyncHybridCache.init(BasicHybridCache.init(name: "json"))
        let key = "jsonobj"
        let data:Data! = cache.object(key)
        let resp:PPGetHomeOpusListResp! = NSKeyedUnarchiver.unarchiveObject(with: data) as! PPGetHomeOpusListResp
        self.presentAlert(msg: resp.description)
    }
    
    
    func jsontomodel() -> () {
         self.loadfromlocal()
    }
    
    
    func loadfromnetwork() -> () {
        
        SVProgressHUD.show()
        Alamofire.request("http://7xicym.com1.z0.glb.clouddn.com/popaimg/PPGetHomeOpusListResp.json").responseJSON { (response:DataResponse) in
            
            do{
                let json = try SwiftyJSON.JSON.init(data: response.data!)
                let resp = PPGetHomeOpusListResp.init(fromJson: json)
                self.jsonobj = json;
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
                let json = try SwiftyJSON.JSON(data: data)
                self.jsonobj = json
                let resp = PPGetHomeOpusListResp.init(fromJson: json);
                print(resp.description);
                self.presentAlert(msg: json.description)
            } catch {
                self.jsonobj = SwiftyJSON.JSON.null
            }
        } else {
            self.jsonobj = SwiftyJSON.JSON.null
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
