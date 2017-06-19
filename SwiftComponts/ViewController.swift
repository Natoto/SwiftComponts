//
//  ViewController.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/9.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit
import Alamofire
import HBKit

class ViewController: HBBaseTableViewController {

    override func cs_titles() -> [String] {
        return ["【0】网络封装",
                "【1】数据库，序列化缓存",
                "【2】model,字典与json互转",
                "【3】原生与js互调",
                "【4】富文本快速生成与使用",
                "【5】上下拉加载",
                "【6】RAC 数据流控制与刷新",
                "【7】方法交换转移大法",
                "【8】多线程常用操作封装",
                "【9】全屏滑动代码",
                "【10】navigationbar和toolbar的创建",
                "【11】url路由封装",
                "【12】自定义弹窗，分享模块",
                "【13】视频图片浏览器",
                "【14】图片裁剪轮子"];
    }
    
    override func cs_selectAction(cs: HBCellStruct) {
        
        var ctr = UIViewController.init()
        if cs.key_indexpath == self.key_indexpath(0, row: 0) {
             ctr = NetWorkViewController.init()
        }
        else if cs.key_indexpath == cs.key_indexpath(0, row: 1)
        {
             ctr = ModelExViewController.init()
        }
        else if cs.key_indexpath == cs.key_indexpath(0, row: 2)
        {
            ctr = ModelExViewController.init()
        }
        else if cs.key_indexpath == cs.key_indexpath(0, row: 3)
        {
             ctr = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") 
        }
        else if cs.key_indexpath == cs.key_indexpath(0, row: 12){
            ctr = CustomAlertViewController.init()
        }
        else if cs.key_indexpath == cs.key_indexpath(0, row: 13){
            ctr = ImageCollectionViewController.init()
        }
        ctr.title = cs.title;
        ctr.view.backgroundColor = UIColor.white;
        self.navigationController?.pushViewController(ctr, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cs_loadcsdata()
        self.title = "swift开发项目最佳实践";
        let urlString = "http://httpbin.org/get"
        
        let parameters: Parameters = ["foo": "bar"]
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("进度: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // 自定义的校验闭包, 现在加上了 `data` 参数(允许你提前转换数据以便在必要时挖掘到错误信息)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

