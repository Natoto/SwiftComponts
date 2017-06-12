//
//	Data.swift
//
//	Create by boob on 12/6/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class OpusResponseData : NSObject, NSCoding{

	var isNextPage : Int!
	var opusList : [OpusList]!
	var userId : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		isNextPage = json["isNextPage"].intValue
		opusList = [OpusList]()
		let opusListArray = json["opusList"].arrayValue
		for opusListJson in opusListArray{
			let value = OpusList(fromJson: opusListJson)
			opusList.append(value)
		}
		userId = json["userId"].intValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if isNextPage != nil{
			dictionary["isNextPage"] = isNextPage
		}
		if opusList != nil{
			var dictionaryElements = [NSDictionary]()
			for opusListElement in opusList {
				dictionaryElements.append(opusListElement.toDictionary())
			}
			dictionary["opusList"] = dictionaryElements
		}
		if userId != nil{
			dictionary["userId"] = userId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         isNextPage = aDecoder.decodeObject(forKey: "isNextPage") as? Int
         opusList = aDecoder.decodeObject(forKey: "opusList") as? [OpusList]
         userId = aDecoder.decodeObject(forKey: "userId") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if isNextPage != nil{
			aCoder.encode(isNextPage, forKey: "isNextPage")
		}
		if opusList != nil{
			aCoder.encode(opusList, forKey: "opusList")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}
