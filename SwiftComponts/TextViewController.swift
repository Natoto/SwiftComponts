//
//  TextViewController.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/22.
//  Copyright © 2017年 YY.COM. All rights reserved.
//


let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

import UIKit
import YYText

class TextViewController: UIViewController {
    
    let theText = "右侧A柱:变形、左前梁头:变形、右前梁头:变形、左侧C柱:变形、右后减震器座:变形、行李箱底板:变形、左后纵梁:变形、右后纵梁:变形、左后减震器座:变形、右C柱:漆面薄、右B柱:漆面厚、右A柱:漆面厚、左A柱:漆面厚、左B柱:漆面厚、左C柱:漆面厚、"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(label1)
        self.scrollView.addSubview(label2)
        self.scrollView.addSubview(label3)
        self.scrollView.addSubview(label4)
        self.scrollView.addSubview(label5)
        
        
        
        // 选中字体颜色变红
        label1.attributedText = NSMutableAttributedString.attributenStringColor(text: theText, selectedText: "变形", allColor: UIColor.black, selectedColor: UIColor.red, fone: 14)
        
        // 指定两个字符中间文字变色
        label2.attributedText = NSMutableAttributedString.attributenStringMutColor(text: theText, allColor: UIColor.black, selectedColor: UIColor.red, firstStr: ":", lastStr: "、", fone: 14)
        
        // 改变行间距
        label3.attributedText = NSMutableAttributedString.lineSpace(text: theText, lineSpace: 20, fone: 14)
        
        // 改变字体
        label4.attributedText = NSMutableAttributedString.attributenStringFont(text: theText, selectedText: "变形", allFont: 14, selectedFont: 20, textColor: UIColor.black)
    
       
        var  txt = NSMutableAttributedString.init()
        txt = self.addText(txt: txt)
        txt = self.addText(txt: txt)
        label5.attributedText = txt;
    
        
        var complete : ((String) -> ())
//
//        label5.highlightTapAction = ((UIView,NSAttributedString,NSRange,CGRect) -> ()){
//        
//        }
    
    }
    func addText(txt:NSMutableAttributedString) -> NSMutableAttributedString {
        let one = NSMutableAttributedString.init(string: "Shadow")
        one.yy_font = UIFont.systemFont(ofSize: 30)
        one.yy_color = UIColor.white;
        let shadow = YYTextShadow.init()
        shadow.color = UIColor.init(colorLiteralRed: 0, green: 1, blue: 1, alpha: 0.49)
        shadow.offset = CGSize.init(width: 0, height: 1)
        shadow.radius = 5
        one.yy_textShadow = shadow
        txt.append(one)
        return txt;
    }
    
    private lazy var label1: UILabel = {
        let lb = UILabel(frame: CGRect(x: (kScreenWidth - 200)/2, y: 50, width: 200, height: 200))
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.backgroundColor = UIColor.white
        lb.layer.borderColor = UIColor.lightGray.cgColor
        lb.layer.borderWidth = 1
        lb.numberOfLines = 0
        
        return lb
    }()
    
    private lazy var label2: UILabel = {
        let lb = UILabel(frame: CGRect(x: (kScreenWidth - 200)/2, y: 300, width: 200, height: 200))
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.backgroundColor = UIColor.white
        lb.layer.borderColor = UIColor.lightGray.cgColor
        lb.layer.borderWidth = 1
        lb.numberOfLines = 0
        
        return lb
    }()
    
    private lazy var label3: UILabel = {
        let lb = UILabel(frame: CGRect(x: (kScreenWidth - 200)/2, y: 550, width: 200, height: 360))
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.backgroundColor = UIColor.white
        lb.layer.borderColor = UIColor.lightGray.cgColor
        lb.layer.borderWidth = 1
        lb.numberOfLines = 0
        
        return lb
    }()
    
    
    private lazy var label4: UILabel = {
        let lb = UILabel(frame: CGRect(x: (kScreenWidth - 200)/2, y: 1000, width: 200, height: 200))
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.backgroundColor = UIColor.white
        lb.layer.borderColor = UIColor.lightGray.cgColor
        lb.layer.borderWidth = 1
        lb.numberOfLines = 0
        
        return lb
    }()
    
    private lazy var label5: YYLabel = {
        let lb = YYLabel(frame: CGRect(x: (kScreenWidth - 200)/2, y: 1210, width: 200, height: 200))
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.backgroundColor = UIColor.white
        lb.layer.borderColor = UIColor.lightGray.cgColor
        lb.layer.borderWidth = 1
        lb.numberOfLines = 0
//        lb.backgroundColor = UIColor.init(colorLiteralRed: 1, green: 0.3, blue: 1, alpha: 1);
        // [UIColor colorWithWhite:0.933 alpha:1.000];
        
        return lb
    }()
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight*2.5)
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()

}
