//
//  NetWorkViewController.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/9.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit
import HBKit
import Alamofire
import SVProgressHUD

class NetWorkViewController: HBBaseTableViewController {

    override func cs_titles() -> [String] {
        return ["Alamofire get 方法","Alamofire post 方法","Alamofire download 方法"]
    }
    
    override func cs_selectAction(cs: HBCellStruct) {
        
       self.logmethod()
        if cs.key_indexpath == self.key_indexpath(0, row: 0) {
             self.testalget()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 1){
            self.testalpost()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 2){
            self.testdownload()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cs_loadcsdata()
        // Do any additional setup after loading the view.
        
    }
    
    //MARK: 添加
    func testalget() -> () {
    
        SVProgressHUD.show()
        let urlString = "http://httpbin.org/get"
        Alamofire.request(urlString).responseJSON { (response:DataResponse) in
        
            let json:String? = NSString.init(data:response.data!, encoding: String.Encoding.utf8.rawValue) as String?
            print(json!)
            SVProgressHUD.showSuccess(withStatus: "完成")
            self.run_after(sec: 1, complete: {
                   UIAlertView.init(title: "提示", message: json, delegate: nil, cancelButtonTitle: "OK").show()
            })
        }
    }
    //MARK: post
    func testalpost() -> () {
       
         let parameters = [
            "one": [1,2,3],
            "two": ["apple": "pig"]
        ] as [String : Any]
        
        let urlString = "http://httpbin.org/post"
        
        SVProgressHUD.show()
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response:DataResponse) in
            let json:String? = NSString.init(data:response.data!, encoding: String.Encoding.utf8.rawValue) as String?
            print(json!)
            SVProgressHUD.showSuccess(withStatus: "")
            
            let time = DispatchTime.now() + .milliseconds(50)
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                UIAlertView.init(title: "提示", message: json, delegate: nil, cancelButtonTitle: "OK").show()
            })
        }
    }
    
    let destination: DownloadRequest.DownloadFileDestination = { _, response in
       let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
       
        let fileURL:NSURL = documentsURL.appendingPathComponent((response.suggestedFilename?.urlDecode()!)!) as NSURL
        //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
        return (fileURL as URL, [.removePreviousFile, .createIntermediateDirectories])
    }
    
    func testdownload() -> () {
        //开始下载
        let urlString:String = "http://7xicym.com1.z0.glb.clouddn.com/dedao/001号知识发布会 | 向终身学习者致敬.html"
        
        let escapedString:String = urlString.urlEncode()!
        
        print(escapedString)
       
        SVProgressHUD.show()
        Alamofire.download(escapedString, to: destination)
            .response { response in
                print(response)
                if let imagePath = response.destinationURL?.path {
//                    let image = UIImage(contentsOfFile: imagePath)
                    print("下载成功，保存在\(imagePath)")
                    SVProgressHUD.showSuccess(withStatus: "成功")
                }
                else{
                    SVProgressHUD.dismiss()
                }
            }.downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("进度: \(progress.fractionCompleted)")
               SVProgressHUD.showProgress(Float(progress.fractionCompleted))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
