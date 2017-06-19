
//
//  WebViewController.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/19.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit
import HBKit
import SVProgressHUD


class WebViewController: HBBaseViewController {
    
    
    // already set delegate to current ViewController in storyboard
    @IBOutlet weak var webView: UIWebView!
    
    
    @IBOutlet weak var sendDataToJSBt: UIButton!
    
    @IBOutlet weak var sendDataToJSWithCallBackBt: UIButton!
    
    @IBOutlet weak var callJSHandlerBt: UIButton!
    
    @IBOutlet weak var callJSHandlerWithCallBackBt: UIButton!
    
    
    fileprivate var numOfLoadingRequest = 0
    
    fileprivate var bridge: SwiftWebViewBridge!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bridge = SwiftWebViewBridge.bridge(webView, defaultHandler: { data, responseCallback in
            print("Swift received message from JS: \(data)")
            // Actually, this responseCallback could be an empty closure when javascript has no callback, saving you from unwarping an optional parameter = )
            // responseCallback is modified by @escaping
            SVProgressHUD.showInfo(withStatus: "收到网页发出的信息")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                // Simulating the situation that needs to do some   asynchronous tasks
                responseCallback(["msg": "Swift already got your msg, thanks"])
            }
        })
        
        //  SwiftJavaScriptBridge.logging = false
        
        self.bridge.registerHandlerForJS(handlerName: "printReceivedParmas", handler: { [unowned self] jsonData, responseCallback in
            // if you used self in any bridge handler/callback closure, remember to declare weak or unowned self, preventing from retaining cycle!
            // Because VC owned bridge, brige owned this closure, and this cloure captured self!
            self.printReceivedParmas(jsonData)
            SVProgressHUD.showSuccess(withStatus: "APP收到带回调的消息")
            responseCallback([
                "msg": "Swift has already finished its handler",
                "returnValue": [1, 2, 3]
                ])
        })
        
        self.bridge.sendDataToJS([
            "msg": "Hello JavaScript, My name is 小明",
            "gift": [
                "100CNY",
                "1000CNY",
                "10000CNY"
            ]
            ])
        
        self.loadLocalWebPage()
    }
}

// MARK: - UIViewController + UIWebViewDelegate

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.numOfLoadingRequest += 1
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.numOfLoadingRequest -= 1
        if (self.numOfLoadingRequest == 0) {
            self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
            self.sendDataToJSBt.isEnabled = true
            self.sendDataToJSWithCallBackBt.isEnabled = true
            self.callJSHandlerBt.isEnabled = true
            self.callJSHandlerWithCallBackBt.isEnabled = true
           
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("\(error)")
    }
}

// MARK: - ViewController + Actions

extension WebViewController     {
    
    @IBAction func sendDataToJS(_ sender: AnyObject) {
        self.bridge.sendDataToJS(["msg": "向网页js发消息 Hello JavaScript", "gift": ["100CNY", "1000CNY", "10000CNY"]])
    }
    
    @IBAction func sendDataToJSWithCallback(_ sender: AnyObject) {
        self.bridge.sendDataToJS(["msg":"Did you received my gift, JS?"], responseCallback: { data in
            print("Receiving JS return gift: \(data)")
            SVProgressHUD.showSuccess(withStatus: "发送消息成功")
        })
    }
    
    @IBAction func callJSHandler(_ sender: AnyObject) {
        self.bridge.callJSHandler("alertReceivedParmas", params: ["msg": "原生调用网页中JS的方法JS, are you there? ", "num": 5], responseCallback: nil)
    }
    
    @IBAction func callJSHandlerWithCallback(_ sender: AnyObject) {
        self.bridge.callJSHandler("alertReceivedParmas", params: ["msg": "(带回调的)原生调用网页中JS的方法JS, I know you there!"]) { data in
            print("Got response from js: \(data)")
            SVProgressHUD.showSuccess(withStatus: "调用成功")
        }
    }
    
    
    
    fileprivate func printReceivedParmas(_ data: AnyObject) {
        print("Swift recieved data passed from JS: \(data)")
    }
    
    fileprivate func loadLocalWebPage() {
        guard let urlPath = Bundle.main.url(forResource: "index", withExtension: "html") else {
            print("Couldn't find the Demo.html file in bundle!")
            return
        } 
        var urlString: String
        do {
            urlString  = try String(contentsOf: urlPath)
            self.webView.loadHTMLString(urlString, baseURL: urlPath)
        }
        catch let error as NSError {
            NSLog("\(error)")
            return
        }
    }


}

