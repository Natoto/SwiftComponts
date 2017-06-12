//
//	RootClass.swift
//
//	Create by boob on 12/6/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class RootClass : NSObject, NSCoding{

	var pPGetHomeOpusListResp : PPGetHomeOpusListResp!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		let pPGetHomeOpusListRespJson = json["PPGetHomeOpusListResp"]
		if !pPGetHomeOpusListRespJson.isEmpty{
			pPGetHomeOpusListResp = PPGetHomeOpusListResp(fromJson: pPGetHomeOpusListRespJson)
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if pPGetHomeOpusListResp != nil{
			dictionary["PPGetHomeOpusListResp"] = pPGetHomeOpusListResp.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         pPGetHomeOpusListResp = aDecoder.decodeObject(forKey: "PPGetHomeOpusListResp") as? PPGetHomeOpusListResp

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if pPGetHomeOpusListResp != nil{
			aCoder.encode(pPGetHomeOpusListResp, forKey: "PPGetHomeOpusListResp")
		}

	}

}