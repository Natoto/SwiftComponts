//
//	PPGetHomeOpusListResp.swift
//
//	Create by boob on 12/6/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class PPGetHomeOpusListResp : NSObject, NSCoding{

	var code : Int!
	var data : OpusResponseData!
	var msg : String!
	var times : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		code = json["code"].intValue
		let dataJson = json["data"]
		if !dataJson.isEmpty{
			data = OpusResponseData(fromJson: dataJson)
		}
		msg = json["msg"].stringValue
		times = json["times"].intValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if code != nil{
			dictionary["code"] = code
		}
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
		if msg != nil{
			dictionary["msg"] = msg
		}
		if times != nil{
			dictionary["times"] = times
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? Int
         data = aDecoder.decodeObject(forKey: "data") as? OpusResponseData
         msg = aDecoder.decodeObject(forKey: "msg") as? String
         times = aDecoder.decodeObject(forKey: "times") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if msg != nil{
			aCoder.encode(msg, forKey: "msg")
		}
		if times != nil{
			aCoder.encode(times, forKey: "times")
		}

	}

}
