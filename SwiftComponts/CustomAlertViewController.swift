//
//  CustomAlertViewController.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/12.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit
import HBKit
import JCAlertController
import NSObjectBlockSEL

class CustomAlertViewController: HBBaseTableViewController {

    override func cs_titles() -> [String] {
        return ["显示文字","更改样式","自定义内容"];
    }
    
    override func cs_selectAction(cs: HBCellStruct) {
        if cs.key_indexpath == self.key_indexpath(0, row: 0) {
            self.showmsg()
        }
        else if cs.key_indexpath ==  self.key_indexpath(0, row: 1){
            self.customstyle()
        }
        else if cs.key_indexpath ==  self.key_indexpath(0, row: 2){
            self.customView()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cs_loadcsdata()
        
//        let button = UIButton.createButton(withFrame: CGRect.init(x: 10, y: 70, width: 100, height: 60), andTxt: "click me")
//        self.view.addSubview(button!)
//        button?.addTarget(self, action: #selector(buttontap), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    func buttontap() -> () {
       self.logmethod()
    }
    
    func showmsg() -> () {
        let alert = JCAlertController.alert(withTitle: "长文字测试", message: self.alt_longcontent())
        alert?.addButton(withTitle: "Cancel", type: JCButtonType(rawValue: 0), clicked: {
           print("点击了取消")
        })
        alert?.addButton(withTitle: "OK", type: JCButtonType(rawValue: 0), clicked: {
            print("点击了确定")
        })
        self.jc_present(alert, presentCompletion: {
            print("弹起来")
        }) {
           print("消失")
        }
    }
    
    
    func customstyle() -> () {
        
        let style = JCAlertStyle.share()
        style?.background.blur = true;
        style?.background.alpha = 0.65;
        style?.background.canDismiss = true;
        
        style?.alertView.cornerRadius = 4.0;
        
        style?.title.backgroundColor = UIColor.rgb(r: 251, g: 2, b: 19, a: 1);
        style?.title.textColor = UIColor.white;
        
        style?.content.backgroundColor = UIColor.rgb(r: 2, g: 2, b: 19)
        style?.content.textColor = UIColor.white;
        style?.content.insets = UIEdgeInsetsMake(20, 20, 40, 20)
        
        style?.buttonNormal.textColor = UIColor.rgb(r: 248, g: 59, b: 50)
        style?.buttonNormal.backgroundColor = UIColor.white;
        style?.buttonNormal.highlightTextColor = UIColor.green;
        
        let alert = JCAlertController.alert(withTitle: "自定义风格测试", message: "弹窗背景颜色，文字颜色，点击按钮自定义")
        alert?.addButton(withTitle: "Cancel", type: JCButtonType(rawValue: 0), clicked: {
            print("点击了取消")
        })
        alert?.addButton(withTitle: "OK", type: JCButtonType(rawValue: 0), clicked: {
            print("点击了确定")
        })
        self.jc_present(alert, presentCompletion: {
            print("弹起来")
        }) {
            print("消失")
        }
    }

    func customView() -> () {
        let width = JCAlertStyle.share().alertView.width;
        let contentView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: width*0.623));
        contentView.image = UIImage.init(named: "alert")
        contentView.isUserInteractionEnabled = true;
        
        let alert = JCAlertController.alert(withTitle: nil, contentView: contentView)
        self.jc_present(alert, presentType: JCPresentType(rawValue:0), presentCompletion: {
            
        }) { 
            
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action:self.selectorBlock({ (weakself, param) in
            alert?.dismiss(animated: true, completion: nil)
        }))
        
        contentView.addGestureRecognizer(tap)
    }
    func customContantviewTap(sender:UITapGestureRecognizer) -> () {
        sender.view?.removeFromSuperview()
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



extension NSObject{
    
    func alt_identifier() -> String {
        return "identifier"
    }
    
    func alt_longTitle() -> String {
        return "I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title I am title"
    }
    
    func alt_longcontent() -> String {
         return "I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content I am content "
    }
}
