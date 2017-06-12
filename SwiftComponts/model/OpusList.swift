//
//	OpusList.swift
//
//	Create by boob on 12/6/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class OpusList : NSObject, NSCoding{

	var addressId : Int!
	var addressImg : String!
	var addressName : String!
	var commCount : Int!
	var createDate : Int!
	var id : Int!
	var latitude : Int!
	var longitude : Int!
	var msgCount : Int!
	var opusDesc : String!
	var opusImg : String!
	var opusName : String!
	var opusType : Int!
	var praiseCount : Int!
	var userId : Int!
	var userImg : String!
	var userName : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		addressId = json["addressId"].intValue
		addressImg = json["addressImg"].stringValue
		addressName = json["addressName"].stringValue
		commCount = json["commCount"].intValue
		createDate = json["createDate"].intValue
		id = json["id"].intValue
		latitude = json["latitude"].intValue
		longitude = json["longitude"].intValue
		msgCount = json["msgCount"].intValue
		opusDesc = json["opusDesc"].stringValue
		opusImg = json["opusImg"].stringValue
		opusName = json["opusName"].stringValue
		opusType = json["opusType"].intValue
		praiseCount = json["praiseCount"].intValue
		userId = json["userId"].intValue
		userImg = json["userImg"].stringValue
		userName = json["userName"].stringValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if addressId != nil{
			dictionary["addressId"] = addressId
		}
		if addressImg != nil{
			dictionary["addressImg"] = addressImg
		}
		if addressName != nil{
			dictionary["addressName"] = addressName
		}
		if commCount != nil{
			dictionary["commCount"] = commCount
		}
		if createDate != nil{
			dictionary["createDate"] = createDate
		}
		if id != nil{
			dictionary["id"] = id
		}
		if latitude != nil{
			dictionary["latitude"] = latitude
		}
		if longitude != nil{
			dictionary["longitude"] = longitude
		}
		if msgCount != nil{
			dictionary["msgCount"] = msgCount
		}
		if opusDesc != nil{
			dictionary["opusDesc"] = opusDesc
		}
		if opusImg != nil{
			dictionary["opusImg"] = opusImg
		}
		if opusName != nil{
			dictionary["opusName"] = opusName
		}
		if opusType != nil{
			dictionary["opusType"] = opusType
		}
		if praiseCount != nil{
			dictionary["praiseCount"] = praiseCount
		}
		if userId != nil{
			dictionary["userId"] = userId
		}
		if userImg != nil{
			dictionary["userImg"] = userImg
		}
		if userName != nil{
			dictionary["userName"] = userName
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         addressId = aDecoder.decodeObject(forKey: "addressId") as? Int
         addressImg = aDecoder.decodeObject(forKey: "addressImg") as? String
         addressName = aDecoder.decodeObject(forKey: "addressName") as? String
         commCount = aDecoder.decodeObject(forKey: "commCount") as? Int
         createDate = aDecoder.decodeObject(forKey: "createDate") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         latitude = aDecoder.decodeObject(forKey: "latitude") as? Int
         longitude = aDecoder.decodeObject(forKey: "longitude") as? Int
         msgCount = aDecoder.decodeObject(forKey: "msgCount") as? Int
         opusDesc = aDecoder.decodeObject(forKey: "opusDesc") as? String
         opusImg = aDecoder.decodeObject(forKey: "opusImg") as? String
         opusName = aDecoder.decodeObject(forKey: "opusName") as? String
         opusType = aDecoder.decodeObject(forKey: "opusType") as? Int
         praiseCount = aDecoder.decodeObject(forKey: "praiseCount") as? Int
         userId = aDecoder.decodeObject(forKey: "userId") as? Int
         userImg = aDecoder.decodeObject(forKey: "userImg") as? String
         userName = aDecoder.decodeObject(forKey: "userName") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if addressId != nil{
			aCoder.encode(addressId, forKey: "addressId")
		}
		if addressImg != nil{
			aCoder.encode(addressImg, forKey: "addressImg")
		}
		if addressName != nil{
			aCoder.encode(addressName, forKey: "addressName")
		}
		if commCount != nil{
			aCoder.encode(commCount, forKey: "commCount")
		}
		if createDate != nil{
			aCoder.encode(createDate, forKey: "createDate")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}
		if msgCount != nil{
			aCoder.encode(msgCount, forKey: "msgCount")
		}
		if opusDesc != nil{
			aCoder.encode(opusDesc, forKey: "opusDesc")
		}
		if opusImg != nil{
			aCoder.encode(opusImg, forKey: "opusImg")
		}
		if opusName != nil{
			aCoder.encode(opusName, forKey: "opusName")
		}
		if opusType != nil{
			aCoder.encode(opusType, forKey: "opusType")
		}
		if praiseCount != nil{
			aCoder.encode(praiseCount, forKey: "praiseCount")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}
		if userImg != nil{
			aCoder.encode(userImg, forKey: "userImg")
		}
		if userName != nil{
			aCoder.encode(userName, forKey: "userName")
		}

	}

}