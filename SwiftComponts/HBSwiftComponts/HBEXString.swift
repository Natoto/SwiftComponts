//
//  HBEXString.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/12.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

import UIKit

extension String{
    
    func UTF8ToGB2312() -> (NSData?, UInt) {
        let enc              = CFStringConvertEncodingToNSStringEncoding(UInt32(CFStringEncodings.GB_18030_2000.rawValue))
        let data             = self.data(using: String.Encoding(rawValue: enc), allowLossyConversion: false)
        return (data! as NSData, enc)
    }
    
    // 字符串转二进制数据 utf8
    func utfdata() -> NSData{
        let str = self
        let utf8Data = str.data(using: String.Encoding.utf8)
    
        return utf8Data! as NSData;
    }
    
    func base64String() -> String {
        // base 编码
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!;
    }
    
    func deBase64String() -> String {
       
         let decodedData = NSData.init(base64Encoded: self, options:NSData.Base64DecodingOptions.ignoreUnknownCharacters)
         let data = decodedData?.subdata(with: NSMakeRange(0, (decodedData?.length)!))
        let decodedString = NSString.init(data: data!, encoding:String.Encoding.utf8.rawValue);
         //NSString(data: data!, encoding: NSUTF8StringEncoding.rawValue)
        
        return decodedString! as String;

    }
    
    // url decode
    func urlDecode() ->String! {
        return self.removingPercentEncoding
    }
    
    func urlEncode() -> String! {
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        return escapedString
    }
    
    //拆分字典到url字符串
    static func queryStringFromParameters(parameters: Dictionary<String,String>) -> String? {
        if (parameters.count == 0)
        {
            return nil
        }
        var queryString : String? = nil
        for (key, value) in parameters {
            if let encodedKey = key.urlEncode() {
                if let encodedValue = value.urlEncode() {
                    if queryString == nil
                    {
                        queryString = "?"
                    }
                    else
                    {
                        queryString! += "&"
                    }
                    queryString! += encodedKey + "=" + encodedValue
                }
            }
        }
        return queryString
    }
 

}
class HBEXString: NSObject {

}
